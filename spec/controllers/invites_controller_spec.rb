describe InvitesController, '#create', type: :controller do
  include AuthHelper

  let(:sender)         { create(:user) }
  let(:recipient)      { create(:user) }

  let(:invitable)      { create(:quotation) }
  let(:invitable_id)   { invitable.id }
  let(:invitable_type) { 'Quotation' }

  let(:params) do
    {
      invite: {
        email: recipient.email,
        invitable_id: invitable_id,
        invitable_type: invitable_type
      }
    }
  end

  before { auth_request sender }

  context 'when user is authenticated' do
    it 'sends an invite' do
      post :create, params: params
      expect(response).to have_http_status(:created)
    end
  end

  context 'when invitable is invalid' do
    context 'and has a wrong type' do
      let!(:invitable_type) { :invalid }

      it 'renders a bad request error' do
        post :create, params: params
        expect(response).to have_http_status(:bad_request)
        expect(json_body['errors']).to eq ['Unable to send invite']
      end
    end

    context 'and has a wrong id' do
      let!(:invitable_id) { 0 }

      it 'renders an unprocessable entity error' do
        post :create, params: params
        expect(response).to have_http_status(:unprocessable_entity)
        expect(json_body['errors']).to eq ['Invitable must exist']
      end
    end
  end
end
