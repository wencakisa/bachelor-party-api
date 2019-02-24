class PartyMailer < ApplicationMailer
  def notify_guide_for_party_assignment(party)
	@party = party
	mail to: party.guide.email, subject: 'You have been assigned to ' + party.title.downcase
  end

  def notify_guide_for_party_unassignment(party, guide_email)
	@party = party
	mail to: guide_email, subject: 'You have been unassigned from ' + party.title.downcase
  end
end
