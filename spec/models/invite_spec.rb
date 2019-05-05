require 'rails_helper'

describe Invite, type: :model do
  describe '#generate_token' do
    it 'generates secure token after created' do
      invite = create(:invite)

      expect(invite.token).to be_truthy
    end
  end

  describe '#set_recipient_if_exists' do
    it 'sets recipient if user with the same email already exists' do
      email = 'user@email.com'
      create(:user, email: email)
      invite = create(:invite, email: email)

      expect(invite.recipient).to be_truthy
      expect(invite.recipient.email).to eq email
    end
  end

  # describe '#notify_recipient' do
  #   it 'notifies recipient when invite is generated' do
  #     invite = create(:invite)

  #     message_delivery = instance_double(ActionMailer::MessageDelivery)
  #     expect(InviteMailer).to receive(:new_user_invite).with(invite).and_return(message_delivery)
  #     allow(message_delivery).to receive(:deliver_later)
  #   end
  # end
end
