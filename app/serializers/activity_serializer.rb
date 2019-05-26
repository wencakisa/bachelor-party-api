class ActivitySerializer < ActiveModel::Serializer
  attributes :id, :title, :subtitle, :duration, :time_type, :image_url

  has_many :prices
end
