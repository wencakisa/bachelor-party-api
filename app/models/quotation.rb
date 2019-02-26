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

  validates_date :date, on_or_after: lambda { Date.current }

  validates_presence_of :user_email
  validates_presence_of :activities
  validates_presence_of :prices

  validate :activities_have_available_prices?,
           :activites_have_single_chosen_price?,
           :prices_are_valid_for_each_activity?

  after_commit :invite_user_from_email, :create_party, on: :update

  STATUSES = %i[pending rejected approved].freeze
  enum status: STATUSES

  scope :by_status, -> status { where(status: status) }

  def process_user(user)
    self.party.update_attributes(host: user)
  end

  def as_json(options = {})
    super(
      only: %i[id group_size user_email status date],
      include: {
        activities: { only: %i[id title] },
        prices:     { only: %i[id amount options] }
      }
    )
  end

  def activities_have_available_prices?
    activities.each do |activity|
      if activity.prices.empty?
        errors.add(
          :activities,
          'should have available prices in order to request them'
        )
      end
    end
  end

  def activites_have_single_chosen_price?
    if activities.size != prices.size
      errors.add(:activities, 'should have a single price for each one')
    end
  end

  def prices_are_valid_for_each_activity?
    return unless errors.blank?

    activities.each_with_index do |activity, idx|
      price = prices[idx]

      unless activity.prices.include?(price)
        errors.add(
          :price,
          "id #{price.id} is not valid for the activity with id #{activity.id}"
        )
      end
    end
  end

  private

  def user_already_exists?
    User.exists?(email: self.user_email)
  end

  def invite_user_from_email
    if self.approved? && self.invite.nil?
      sender = User.by_role(:admin).first

      invite = Invite.new(email: self.user_email, sender_id: sender.id, invitable: self)

      if user_already_exists?
        invite.recipient_id = User.find_by(email: self.user_email).id
      end

      invite.save!
    end
  end

  def create_party
    if self.approved? && self.party.nil?
      party_attributes = {
        quotation: self,
        title: "Party of #{self.user_email}"
      }

      # User already exists, so we can set him as a party host
      if user_already_exists?
        party_attributes[:host] = User.find_by(email: self.user_email)
      end

      Party.create!(**party_attributes)
    end
  end
end
