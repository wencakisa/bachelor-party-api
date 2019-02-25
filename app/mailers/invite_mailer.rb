class InviteMailer < ApplicationMailer
  def new_user_invite(invite)
    @invite = invite

    client_api_url = Rails.application.credentials.client[:register_url]
    @url = "#{client_api_url}?invitation_token=#{@invite.token}"

    mail to: @invite.email, subject: 'Invite for ' + @invite.invitable_type
  end
end
