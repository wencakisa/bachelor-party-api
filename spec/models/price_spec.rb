require 'rails_helper'

describe Price, type: :model do
  subject(:price) { create(:price) }

  describe 'associations' do
    it 'belongs to an activity' do
      activity = described_class.reflect_on_association(:activity)
      expect(activity.macro).to eq(:belongs_to)
    end

    it 'has and belongs to many quotations' do
      quotations = described_class.reflect_on_association(:quotations)
      expect(quotations.macro).to eq(:has_and_belongs_to_many)
    end
  end

  it 'is invalid when amount is missing' do
    price.amount = nil
    expect(price).to_not be_valid
  end

  it 'is invalid when amount is a negative number' do
    price.amount = -1
    expect(price).to_not be_valid
  end
end
