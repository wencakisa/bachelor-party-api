class Quotation < ApplicationRecord
  validates :group_size,
            presence: true,
            numericality: {
              greater_than_or_equal_to: 1,
              less_than_or_equal_to: 50,
              only_integer: true
            }

  validates_presence_of :user_email

  has_and_belongs_to_many :activities
  validates_presence_of :activities

  has_and_belongs_to_many :prices
  validates_presence_of :prices

  validate :activities_have_available_prices?,
           :activites_have_single_chosen_price?,
           :prices_are_valid_for_each_activity?

  after_update :notify_user_for_status_update, :create_party

  STATUSES = %i[pending rejected approved].freeze
  enum status: STATUSES

  scope :by_status, -> status { where(status: status) }

  def as_json(options = {})
    super(
      only: %i[id group_size status user_email],
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

  def create_party
    if self.status == 'approved'
      Party.create!(quotation: self, title: "Party of #{user_email}")
    end
  end

  def notify_user_for_status_update
    QuotationMailer.updated_status_notification(self).deliver_later
  end
end
