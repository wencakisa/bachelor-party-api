describe Activity, type: :model do
  subject(:activity) { create(:activity) }

  describe 'missing attributes' do
    context 'is invalid without' do
      it 'title' do
        activity.title = nil
        expect(activity).to_not be_valid
      end

      it 'subtitle' do
        activity.subtitle = nil
        expect(activity).to_not be_valid
      end

      it 'duration' do
        activity.duration = nil
        expect(activity).to_not be_valid
      end

      it 'time type' do
        activity.time_type = nil
        expect(activity).to_not be_valid
      end
    end
  end

  describe 'invalid attributes' do
    context 'is invalid when' do
      it 'title is too short' do
        activity.title = ''
        expect(activity).to_not be_valid
      end

      it 'title is too long' do
        activity.title = 'title' * 100
        expect(activity).to_not be_valid
      end

      it 'subtitle is too short' do
        activity.subtitle = 'ok'
        expect(activity).to_not be_valid
      end

      it 'subtitle is too long' do
        activity.subtitle = 'briefly' * 100
        expect(activity).to_not be_valid
      end

      it 'duration is a negative number' do
        activity.duration = -1
        expect(activity).to_not be_valid
      end
    end
  end
end
