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

  context 'guide notifications' do
    let(:guide) { create(:guide) }

    context 'notifies guide on party assignment' do
      it 'sets guide email if guide exists' do
        party.update_attributes(guide: guide)
        expect(party.guide_email).to eq guide.email
      end
    end

    context 'notifies guide on party withdrawal' do
      it 'gets guide email if guide does not exist' do
        party.update_attributes(guide: nil)
        expect(party.guide_email).to be_falsy
      end
    end
  end
end
