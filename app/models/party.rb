class Party < ApplicationRecord
  belongs_to :quotation
  validates_presence_of :quotation

  has_many :activities, through: :quotation

  invitable named_by: :title

  validates :title, presence: true, length: { maximum: 50 }, uniqueness: true
end
