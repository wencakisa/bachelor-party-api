class Activity < ApplicationRecord
  has_and_belongs_to_many :quotations

  has_many :prices, dependent: :destroy
  accepts_nested_attributes_for :prices, allow_destroy: true

  validates :title,
            presence: true,
            length: { in: 1..100 },
            uniqueness: true
  validates :subtitle,
            presence: true,
            length: { in: 5..250 }
  validates :duration,
            presence: true,
            numericality: { greater_than_or_equal_to: 0 }

  validates :time_type, presence: true
  enum time_type: %i[day night]

  scope :by_time_type, ->(time_type) { where(time_type: time_type) }
end
