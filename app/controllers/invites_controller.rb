class InvitesController < ApplicationController
  before_action :authenticate_user!, only: :create

  def create
    @invite = Invite.new(invite_params)
    @invite.sender_id = current_user.id

    begin
      if @invite.save
        json_response @invite, :created
      else
        error_response @invite
      end
    rescue NameError
      render json: { errors: ['Unable to send invite'] }, status: :bad_request
    end
  end

  private

  def invite_params
    params.require(:invite).permit(:email, :invitable_id, :invitable_type)
  end
end
