class ActivitySerializer < ActiveModel::Serializer
  attributes :id, :title, :subtitle, :duration, :time_type

  has_many :prices
end
