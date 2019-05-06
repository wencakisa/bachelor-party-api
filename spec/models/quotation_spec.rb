describe Quotation, 'associations', type: :model do
  subject(:quotation) { create(:quotation) }

  it 'has and belongs to many activities' do
    activities = described_class.reflect_on_association(:activities)
    expect(activities.macro).to eq(:has_and_belongs_to_many)
  end

  it 'has and belongs to many prices' do
    prices = described_class.reflect_on_association(:prices)
    expect(prices.macro).to eq(:has_and_belongs_to_many)
  end
end

describe Quotation, 'attributes', type: :model do
  subject(:quotation) { create(:quotation) }

  context 'when missing' do
    it 'is invalid without a group size' do
      quotation.group_size = nil
      expect(quotation).to_not be_valid
    end

    it 'is invalid without a user email' do
      quotation.user_email = nil
      expect(quotation).to_not be_valid
    end

    it 'is invalid without activities' do
      quotation.activities = []
      expect(quotation).to_not be_valid
    end

    it 'is invalid without prices' do
      quotation.prices = []
      expect(quotation).to_not be_valid
    end
  end

  context 'when activities and prices are invalid' do
    let(:price) { build(:price) }

    it 'is invalid when any activity does not have prices' do
      quotation.activities.first.prices = []
      expect(quotation).to_not be_valid
      expect(quotation.errors).to include 'activities'
    end

    it 'is invalid when activities do not have single price chosen' do
      quotation.prices << price
      expect(quotation).to_not be_valid
      expect(quotation.errors).to include 'activities'
    end

    it 'is invalid when prices are not valid for each activity' do
      quotation.prices.last.delete
      quotation.prices << price
      expect(quotation).to_not be_valid
    end
  end
end

describe Quotation, 'group size validations', type: :model do
  subject(:quotation) { create(:quotation) }

  context 'is invalid when group size' do
    it 'is not an integer' do
      quotation.group_size = 1.23
      expect(quotation).to_not be_valid
    end

    it 'is a negative number' do
      quotation.group_size = -1
      expect(quotation).to_not be_valid
    end

    it 'is too big' do
      quotation.group_size = 100
      expect(quotation).to_not be_valid
    end
  end
end

describe Quotation, 'create party', type: :model do
  subject(:quotation) { create(:quotation) }
  before { create(:admin) }

  context 'when approved' do
    it 'generates an invite with the quotation user email' do
      expect { quotation.approved! }.to change { Invite.count }.by(1)
    end

    it 'sets recipient id if user already exists' do
      user = create(:user)
      quotation.update_attributes(user_email: user.email)
      quotation.approved!

      expect(quotation.invite.recipient_id).to eq user.id
    end
  end
end
