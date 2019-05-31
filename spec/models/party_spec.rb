describe Party, type: :model do
  subject(:party)   { create(:party) }
  let(:user)        { create(:user) }
  let!(:user_party) { UserParty.create!(user: user, party: party) }

  describe '#customers' do
    it 'returns relevant customer users' do
      expect(party.customers.size).to eq(1)
      expect(party.customers.first).to eq(user)
    end
  end

  describe '#process_user' do
    it 'adds user to current party' do
      expect { party.process_user(user) }.to change { UserParty.count }.by(1)
    end
  end

  describe '#date' do
    it 'returns related quotation date' do
      expect(party.date).to eq(party.quotation.date)
    end
  end
end