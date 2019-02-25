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

  scope :by_role, -> role { where(role: role) }

  def parties
    if guide?
      guide_parties
    elsif customer?
      host_parties + super
    end
  end
end
