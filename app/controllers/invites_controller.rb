class InvitesController < ApplicationController
  before_action :authenticate_user!, only: :create

  def create
    @invite = Invite.new(invite_params)
    @invite.sender_id = current_user.id

    if @invite.save
      send_invite_email_to_user
    end

    render json: { success: ['Invite sent!'] }, status: :created
  end

  private

  def invite_params
    params.require(:invite).permit(:email, :invitable_id, :invitable_type)
  end

  def send_invite_email_to_user
    InviteMailer.new_user_invite(@invite).deliver_later
  end
end
