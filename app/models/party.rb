class Party < ApplicationRecord
  has_one :quotation
  has_many :activities, through: :quotation

  invitable named_by: :title

  validates :title, presence: true, length: { maximum: 50 }, uniqueness: true
end
