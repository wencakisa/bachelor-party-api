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

  def role?(role_name)
    role == role_name.to_s
  end
end
