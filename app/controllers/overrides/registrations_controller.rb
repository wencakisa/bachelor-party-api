module Overrides
  class RegistrationsController < DeviseTokenAuth::RegistrationsController
    before_action :resource_from_invitation_token, only: :create

    def create
      if @invite
        @user = User.claim_invitation(accept_invitation_params)

        if @user.errors.empty?
          render json: { success: ['Invitation accepted. Enjoy your party!'], status: 'success' },
                 status: :ok
        else
          render json: { errors: @user.errors.full_messages, status: 'failed' },
                 status: :unprocessable_entity
        end
      else
        super
      end
    end

    private

    def accept_invitation_params
      params.permit(:password, :password_confirmation, :invitation_token)
    end

    def resource_from_invitation_token
      if params[:invitation_token]
        @invite = Invite.find_by_token params[:invitation_token]
        return if @invite

        render json: { errors: ['Invalid token provided!'] }, status: :not_acceptable
      end
    end
  end
end
