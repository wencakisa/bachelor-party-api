describe PartiesController, type: :controller do
  include AuthHelper

  let(:user) { create(:user) }

  describe '#index' do
    context 'when user is not admin' do
      before { create_list(:party, 3, host: user) }

      it 'returns only parties of the current user' do
        auth_request user
        get :index

        expect(json_body.size).to eq 3
      end
    end

    context 'when user is admin' do
      let(:admin) { create(:admin) }
      before { create_list(:party, 3) }

      it 'returns only parties of the current user' do
        auth_request admin
        get :index

        expect(json_body.size).to eq 4
      end
    end
  end

  let(:party) { create(:party, host: user) }
  let(:params) do
    {
      id: party.id
    }
  end

  describe '#show' do
    context 'when party exists' do
      it 'returns the correct party' do
        auth_request user
        get :show, params: params

        expect(json_body['title']).to eq party.title
      end
    end
  end

  describe '#update' do
    context 'when party is updated successfully' do
      it 'returns the updated party' do
        auth_request user

        headers = { 'CONTENT_TYPE' => 'application/json' }
        put :update, "{ party: { title: 'ops' } }", params: params, headers: headers

        expect(party.title).to eq 'ops'
      end
    end

    context 'when party is not updated successfully' do

    end
  end

  describe '#destroy' do

  end

end
