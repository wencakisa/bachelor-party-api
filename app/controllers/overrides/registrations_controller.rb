module Overrides
  class RegistrationsController < DeviseTokenAuth::RegistrationsController
    include Invitation::UserRegistration

    after_action :process_invite_token, only: [:create]
  end
end
