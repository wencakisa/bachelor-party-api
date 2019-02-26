class InviteMailer < ApplicationMailer
  def new_user_invite(invite)
    @invite = invite

    client_api_url = Rails.application.credentials.client[:register_url]
    @url = "#{client_api_url}?invitation_token=#{@invite.token}&resource_type=#{@invite.invitable_type}"

    if @invite.invitable_type == 'Party'
      @party = @invite.invitable
      mail to: @invite.email, subject: "Invite for #{@party.title}"
    elsif @invite.invitable_type == 'Quotation'
      @quotation = @invite.invitable
      mail to: @invite.email, subject: "Your quotation has been #{@quotation.status}"
    end
  end
end
