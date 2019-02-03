# frozen_string_literal: true

class User < ActiveRecord::Base
  include Invitation::User
  include DeviseTokenAuth::Concerns::User

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable

  ROLES = %i[admin guide customer].freeze
  enum role: ROLES
end
