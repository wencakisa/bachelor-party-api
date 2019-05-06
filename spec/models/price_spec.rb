describe Price, type: :model do
  subject(:price) { create(:price) }

  describe 'validations' do
    it 'is invalid when amount is missing' do
      price.amount = nil
      expect(price).to_not be_valid
    end

    it 'is invalid when amount is a negative number' do
      price.amount = -1
      expect(price).to_not be_valid
    end
  end
end
