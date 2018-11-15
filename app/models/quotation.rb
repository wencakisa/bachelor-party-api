class Quotation < ApplicationRecord
  validates :group_size,
            presence: true,
            numericality: {
              greater_than_or_equal_to: 1,
              less_than_or_equal_to: 50,
              only_integer: true
            }

  validates :user_email, presence: true

  has_and_belongs_to_many :activities
  validates :activities, presence: true

  enum status: %i[pending rejected accepted]

  def as_json(options = {})
    super(
      only: %i[id group_size status user_email],
      include: {
        activities: { only: %i[id title] }
      }
    )
  end
end
