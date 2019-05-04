class QuotationSerializer < ActiveModel::Serializer
  attributes :id, :group_size, :user_email, :status, :date

  has_many :activities
  has_many :prices
end
