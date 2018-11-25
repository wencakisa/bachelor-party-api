class Price < ApplicationRecord
  has_and_belongs_to_many :activities

  validates :amount,
            presence: true,
            numericality: { greater_than_or_equal_to: 0 }
end
