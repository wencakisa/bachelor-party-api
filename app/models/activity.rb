class Activity < ApplicationRecord
  has_and_belongs_to_many :quotations

  validates :title,    presence: true,  length: { in: 1..100 }
  validates :subtitle, presence: true,  length: { in: 5..250 }
  validates :duration, presence: true
end
