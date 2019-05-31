describe PartyMailer, '#notify_guide_for_party_assignment', type: :mailer do
  let(:guide) { create(:guide) }
  let(:host)  { create(:host) }
  let(:party) { create(:party, guide: guide, host: host) }
  let(:mail)  { PartyMailer.notify_guide_for_party_assignment(party) }

  it 'sets proper action in subject' do
    expect(mail.subject).to include('assigned')
  end

  it 'adds party title to subject' do
    expect(mail.subject).to include('Party of')
    # expect(mail.subject).to include(party.host.email)
  end
end

describe PartyMailer, '#notify_guide_for_party_withdrawal', type: :mailer do
  let(:guide) { create(:guide) }
  let(:host)  { create(:host) }
  let(:party) { create(:party, guide: guide, host: host) }
  let(:mail) do
    PartyMailer.notify_guide_for_party_withdrawal(party)
  end

  it 'sets proper action in subject' do
    expect(mail.subject).to include('withdrawn')
  end

  it 'adds party title to subject' do
    expect(mail.subject).to include('Party of')
    # expect(mail.subject).to include(party.host.email)
  end
end
