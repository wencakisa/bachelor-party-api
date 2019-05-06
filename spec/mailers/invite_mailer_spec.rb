describe InviteMailer, '#new_user_invite', type: :mailer do
  let(:invitable) { create(:quotation) }
  let(:invite)    { create(:invite, invitable: invitable) }
  let(:mail)      { InviteMailer.new_user_invite(invite) }

  it 'appends invitation token in url' do
    expect(mail.body.raw_source).to include('invitation_token=')
  end

  it 'appends resource type in url' do
    expect(mail.body.raw_source).to include('resource_type=')
  end

  context 'when invite request origin is a quotation' do
    let(:quotation) { invitable }

    it 'contains quotation status in subject' do
      expect(mail.subject).to include(quotation.status)
    end

    it 'appends valid invitable type in url' do
      expect(mail.body.raw_source).to include('Quotation')
    end

    it 'adds quotation custom email message if provided' do
      quotation.update_attributes(custom_email_message: 'additional')

      expect(mail.body.raw_source).to include('additional')
    end
  end

  context 'when invite request origin is a party' do
    let!(:invitable) { create(:party) }
    let(:party)      { invitable }

    it 'contains party title in subject' do
      expect(mail.subject).to include(party.title)
    end
  end
end
