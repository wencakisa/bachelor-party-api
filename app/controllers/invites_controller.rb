class InvitesController < ApplicationController
  before_action :authenticate_user!, only: :create

  def create
    @invite = Invite.new(invite_params)
    @invite.sender_id = current_user.id

    if @invite.save
      render json: { success: ['Invite sent!'] }, status: :created
    else
      render json: { errors: ['Invite could not be sent.'] },
             status: :unprocessable_entity
    end
  end

  private

  def invite_params
    params.require(:invite).permit(:email, :invitable_id, :invitable_type)
  end
end
