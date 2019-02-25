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

  has_many :user_parties
  has_many :parties, through: :user_parties

  has_many :invitations, class_name: 'Invite', foreign_key: :recipient_id
  has_many :sent_invites, class_name: 'Invite', foreign_key: :sender_id

  scope :by_role, -> role { where(role: role) }

  def parties
    if guide?
      guide_parties
    elsif customer?
      host_parties + super
    end
  end

  def self.claim_invitation(claim_params)
    invite = Invite.find_by_token claim_params[:invitation_token]
    return if invite.nil?

    claim_params.delete(:token)

    invitable = invite.invitable

    user_password_from_params = {
      password: claim_params[:password],
      password_confirmation: claim_params[:password_confirmation]
    }

    user = create!(email: invite.email, **user_password_from_params)
    invitable.users.push user
    invite.recipient = user

    invite.status = :accepted
    invite.save

    user
  end
end
