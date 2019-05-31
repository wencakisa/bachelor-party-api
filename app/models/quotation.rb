class Quotation < ApplicationRecord
  has_one :invite,
          as: :invitable,
          required: false,
          dependent: :destroy
  has_one :party, dependent: :destroy

  has_and_belongs_to_many :activities
  has_and_belongs_to_many :prices

  validates :group_size,
            presence: true,
            numericality: {
              greater_than_or_equal_to: 1,
              less_than_or_equal_to: 50,
              only_integer: true
            }

  validates_date :date, on_or_after: -> { Date.current }

  validates_presence_of :user_email
  validates_presence_of :activities
  validates_presence_of :prices

  validate :activities_have_available_prices?,
           :activites_have_single_chosen_price?,
           :prices_are_valid_for_each_activity?

  after_commit :invite_user_from_email, :create_party, on: :update

  STATUSES = %i[pending rejected approved].freeze
  enum status: STATUSES

  scope :by_status, ->(status) { where(status: status) }

  def process_user(user)
    party.update_attributes(host: user)
  end

  def activities_have_available_prices?
    activities.each do |activity|
      next unless activity.prices.empty?

      errors.add(
        :activities,
        'should have available prices in order to request them'
      )
    end
  end

  def activites_have_single_chosen_price?
    return if activities.size == prices.size

    errors.add(:activities, 'should have a single price for each one')
  end

  def prices_are_valid_for_each_activity?
    return unless errors.blank?

    activities.each_with_index do |activity, idx|
      price = prices[idx]

      next if activity.prices.include?(price)

      errors.add(
        :price,
        "id #{price.id} is not valid for the activity with id #{activity.id}"
      )
    end
  end

  private

  def user_already_exists?
    User.exists?(email: user_email)
  end

  def sender
    User.by_role(:admin).first
  end

  def generate_invite
    self.invite = Invite.new(email: user_email, sender_id: sender.id, invitable: self)

    if user_already_exists?
      invite.recipient_id = User.find_by(email: user_email).id
    end

    invite.save!
  end

  def invite_user_from_email
    return if pending? && invite

    generate_invite
  end

  def create_party
    return unless approved? && party.nil?

    # User already exists, so we can set him as a party host
    host ||= User.find_by(email: user_email) if user_already_exists?

    self.party = Party.from_quotation(self, host)
  end
end
