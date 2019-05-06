describe User, type: :model do
  subject(:user) { create(:user) }
  let(:invite)   { create(:invite) }
  let(:claim_params) do
    {
      invitation_token: invite.token,
      password: user.password,
      password_confirmation: user.password_confirmation
    }
  end

  describe '.claim_invite' do
    it 'claims invitation when invite exists' do
      expect do
        User.claim_invitation(claim_params)
      end.to change { User.count }.by(3)
      expect(Invite.last.status).to eq 'accepted'
    end

    it 'sets invite recipient to invited user' do
      user = User.claim_invitation(claim_params)
      expect(user).to eq Invite.last.recipient
    end

    it 'adds invite to user invitations' do
      user = User.claim_invitation(claim_params)
      expect(user.invitations.size).to eq 1
      expect(user.invitations.last.recipient).to eq user
    end
  end

  describe '#parties' do
    context 'when user is guide' do
      subject(:guide) { create(:guide) }
      let(:parties)   { create_list(:party, 3, guide: guide) }

      before { create_list(:party, 2) }

      it 'returns only guide parties' do
        expect(guide.parties).to eq parties
      end
    end
  end
end
