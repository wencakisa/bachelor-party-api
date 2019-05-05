# frozen_string_literal: true

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable

  include DeviseTokenAuth::Concerns::User

  ROLES = %i[admin guide customer].freeze
  enum role: ROLES

  has_many :host_parties,
           class_name: 'Party',
           foreign_key: :host_id,
           inverse_of: :host

  has_many :guide_parties,
           class_name: 'Party',
           foreign_key: :guide_id,
           inverse_of: :guide

  has_many :user_parties, dependent: :destroy
  has_many :parties, through: :user_parties

  has_many :invitations,
           class_name: 'Invite',
           foreign_key: :recipient_id,
           dependent: :destroy

  has_many :sent_invites,
           class_name: 'Invite',
           foreign_key: :sender_id,
           dependent: :destroy

  scope :by_role, ->(role) { where(role: role) }

  def parties
    if guide?
      guide_parties
    elsif customer?
      host_parties + super
    end
  end

  class << self
    def claim_invitation(claim_params)
      invite = Invite.find_by_token claim_params[:invitation_token]
      return if invite.nil?

      claim_params.delete(:token)

      user_password_from_params = claim_params
                                  .slice(:password, :password_confirmation)

      user = create!(email: invite.email, **user_password_from_params)
      user.process_invite(invite)

      user
    end
  end

  def process_invite(invite)
    invite.update_attributes(recipient: self, status: :accepted)
    invite.invitable.process_user self
  end
end
