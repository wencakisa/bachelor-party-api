class Activity < ApplicationRecord
  has_and_belongs_to_many :quotations

  has_and_belongs_to_many :prices
  accepts_nested_attributes_for :prices

  validates :title,    presence: true,  length: { in: 1..100 }
  validates :subtitle, presence: true,  length: { in: 5..250 }
  validates :duration,
            presence: true,
            numericality: { greater_than_or_equal_to: 0 }

  validates :time_type, presence: true
  enum time_type: %i[day night]

  def as_json(options = {})
    super(
      include: {
        prices: { only: %i[id amount options] }
      }
    )
  end
end
