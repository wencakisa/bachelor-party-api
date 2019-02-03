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
  include Invitation::User

  ROLES = %i[admin guide customer].freeze
  enum role: ROLES

  has_many :user_parties
  has_many :parties, through: :user_parties
end
