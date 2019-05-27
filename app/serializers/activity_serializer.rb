class ActivitySerializer < ActiveModel::Serializer
  attributes :id, :title, :subtitle, :details, :duration, :transfer_included, :guide_included, :image_url, :time_type

  has_many :prices
end
