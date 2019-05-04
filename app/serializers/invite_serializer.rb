class InviteSerializer < ActiveModel::Serializer
  attributes :id, :invitable_id, :email
end
