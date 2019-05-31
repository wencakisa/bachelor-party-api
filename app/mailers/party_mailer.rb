class PartyMailer < ApplicationMailer
  def notify_guide_for_party_assignment(party)
    send_mail(party, party.guide.email, 'assigned to')
  end

  def notify_guide_for_party_withdrawal(party)
    send_mail(party, party.last_guide_email, 'withdrawn from')
  end

  private

  def send_mail(party, guide_email, action)
    @party = party
    mail(
      to: guide_email,
      subject: "You have been #{action} the #{party.title.humanize}"
    )
  end
end
