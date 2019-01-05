require 'rails_helper'

RSpec.describe Quotation, type: :model do
  subject(:quotation) { create(:quotation) }

  describe 'attributes' do
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

    context 'when invalid' do
      it 'is invalid when group size is not an integer' do
        quotation.group_size = 1.23
        expect(quotation).to_not be_valid
      end

      it 'is invalid when group size is a negative number' do
        quotation.group_size = -1
        expect(quotation).to_not be_valid
      end

      it 'is invalid when group size is too big' do
        quotation.group_size = 100
        expect(quotation).to_not be_valid
      end
    end
  end

  context 'when activities and prices are invalid' do
    let(:price) { build(:price) }

    it 'is invalid when any activity does not have prices' do
      quotation.activities.first.prices = []
      expect(quotation).to_not be_valid
    end

    it 'is invalid when activities do not have single price chosen' do
      quotation.prices << price
      expect(quotation).to_not be_valid
    end

    it 'is invalid when prices are not valid for each activity' do
      quotation.prices.last.delete
      quotation.prices << price
      expect(quotation).to_not be_valid
    end
  end
end
