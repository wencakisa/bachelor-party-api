describe User, '.claim_invite', type: :model do
  let(:invite) { create(:invite) }
  let(:user) { create(:user) }
  let(:claim_params) do
    {
      invitation_token: invite.token,
      password: user.password,
      password_confirmation: user.password_confirmation
    }
  end

  it 'claims invitation when invite exists' do
    expect { User.claim_invitation(claim_params) }.to change { User.count }.by(3)
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

# describe User, '#parties', type: :model do
#   subject(:customer) { create(:customer) }
#   subject(:guide) { create(:guide) }

#   context 'when user is guide' do
#     it 'returns only guide parties' do
#       expect(guide.parties).to eq
#     end
#   end
# end
