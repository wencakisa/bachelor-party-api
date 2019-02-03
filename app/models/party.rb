class Party < ApplicationRecord
  belongs_to :quotation
  validates_presence_of :quotation

  has_many :activities, through: :quotation

  has_many :user_parties
  has_many :users, through: :user_parties

  invitable named_by: :title

  validates :title, presence: true, length: { maximum: 50 }, uniqueness: true
end
