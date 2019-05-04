class PartySerializer < ActiveModel::Serializer
  attributes :id, :title, :customers, :date

  belongs_to :host
  belongs_to :guide

  has_many :activities
  has_many :invites
end
