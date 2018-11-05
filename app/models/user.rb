# frozen_string_literal: true

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  include DeviseTokenAuth::Concerns::User

  # TODO: Implement user roles and use them with CanCanCan
  # https://github.com/CanCanCommunity/cancancan/wiki/Role-Based-Authorization
end
