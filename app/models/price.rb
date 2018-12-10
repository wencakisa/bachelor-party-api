class Price < ApplicationRecord
  belongs_to :activity, optional: true

  has_and_belongs_to_many :quotations

  validates :amount,
            presence: true,
            numericality: { greater_than_or_equal_to: 0 }
end
