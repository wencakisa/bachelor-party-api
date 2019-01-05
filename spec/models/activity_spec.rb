require 'rails_helper'

RSpec.describe Activity, type: :model do
  subject(:activity) { create(:activity) }

  describe 'associations' do
    it 'has and belongs to many quotations' do
      quotations = described_class.reflect_on_association(:quotations)
      expect(quotations.macro).to eq(:has_and_belongs_to_many)
    end

    it 'has many prices' do
      prices = described_class.reflect_on_association(:prices)
      expect(prices.macro).to eq(:has_many)
    end
  end

  describe 'attributes' do
    context 'when missing' do
      it 'is invalid without a title' do
        activity.title = nil
        expect(activity).to_not be_valid
      end

      it 'is invalid without a subtitle' do
        activity.subtitle = nil
        expect(activity).to_not be_valid
      end

      it 'is invalid without a duration' do
        activity.duration = nil
        expect(activity).to_not be_valid
      end

      it 'is invalid without a time type' do
        activity.time_type = nil
        expect(activity).to_not be_valid
      end
    end

    context 'when invalid' do
      it 'is invalid when title is too short' do
        activity.title = ''
        expect(activity).to_not be_valid
      end

      it 'is invalid when title is too long' do
        activity.title = 'title' * 100
        expect(activity).to_not be_valid
      end

      it 'is invalid when subtitle is too short' do
        activity.subtitle = 'ok'
        expect(activity).to_not be_valid
      end

      it 'is invalid when subtitle is too long' do
        activity.subtitle = 'briefly' * 100
        expect(activity).to_not be_valid
      end

      it 'is invalid when duration is a negative number' do
        activity.duration = -1
        expect(activity).to_not be_valid
      end
    end
  end
end
