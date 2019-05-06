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

        expect(json_body.size).to eq 3
      end
    end
  end

  let(:party) { create(:party) }
  let(:params) do
    { id: party.id }
  end

  describe '#show' do
    context 'when user is host' do
      before { party.update_attributes(host: user) }
      context 'and party exists' do
        it 'returns the correct party' do
          auth_request user
          get :show, params: params

          expect(json_body['title']).to eq party.title
        end
      end

      context 'and party does not exist' do
        it 'raises a not found error' do
          auth_request user
          get :show, params: { id: 0 }

          expect(response).to have_http_status(:not_found)
        end
      end
    end

    context 'when user is guide' do
      before do
        party.update_attributes(guide: user)
        auth_request user
        get :show, params: params
      end

      it 'returns the party' do
        expect(json_body['title']).to eq party.title
      end
    end

    context 'when user is unauthorized' do
      it 'returns an unauthorized response body' do
        get :show, params: params
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe '#update' do
    before { auth_request user }

    context 'when passed params are valid' do
      let(:update_params) { params.merge(party: { title: 'test' }) }

      context 'when user has access permission' do
        before { party.update_attributes(host: user) }

        it 'updates the party' do
          put :update, params: update_params

          expect(response).to have_http_status(:ok)
          expect(json_body['title']).to eq 'test'
        end
      end

      context 'when user is not the party host' do
        it 'renders a forbidden error' do
          put :update, params: update_params

          expect(response).to have_http_status(:forbidden)
        end
      end
    end

    context 'when passed params are invalid' do
      let(:update_params) { params.merge(party: { title: '' }) }

      before { party.update_attributes(host: user) }

      it 'renders an unprocessable entity error' do
        put :update, params: update_params

        expect(response).to have_http_status(:unprocessable_entity)
        expect(json_body['errors']).to eq ["Title can't be blank"]
      end
    end
  end

  describe '#destroy' do
    before { auth_request user }

    context 'when user is the party host' do
      before { party.update_attributes(host: user) }

      it 'destroys the party' do
        delete :destroy, params: params

        expect(response).to have_http_status(:no_content)
      end
    end
  end
end
