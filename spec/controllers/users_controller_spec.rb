describe UsersController, type: :controller do
  include AuthHelper

  let(:admin) { create(:admin) }

  describe '#index' do
    before do
      create_list(:customer, 3)
      create_list(:guide, 2)
    end

    context 'when user is admin' do
      before { auth_request admin }

      context 'and role is not passed' do
        it 'returns all users' do
          get :index

          expect(json_body.size).to eq 6 # me + other users
        end
      end

      context 'and role is passed' do
        it 'returns the specified users' do
          get :index, params: { role: :customer }

          expect(json_body.size).to eq 3
        end
      end
    end
  end

  describe '#create' do
    let(:new_user_attributes) { build(:user).as_json(only: %i[email role]) }
    let(:new_user_password)   { 'tester123' }

    context 'when user is admin' do
      before { auth_request admin }

      context 'and user parameters are valid' do
        let(:params) do
          { user: new_user_attributes.merge(password: new_user_password) }
        end

        it 'creates a new user' do
          expect do
            post :create, params: params
          end.to change { User.count }.by(1)

          expect(response).to have_http_status(:created)
        end
      end

      context 'and user parameters are invalid' do
        let(:params) do
          { user: new_user_attributes } # without password
        end

        it 'renders a unprocessable entity error' do
          post :create, params: params

          expect(response).to have_http_status(:unprocessable_entity)
          expect(json_body['errors']).to eq ["Password can't be blank"]
        end
      end
    end
  end

  describe '#destroy' do
    let(:customer) { create(:customer) }

    before { auth_request admin }

    context 'when user exists' do
      it 'destroys the user' do
        delete :destroy, params: { id: customer.id }

        expect(response).to have_http_status(:no_content)
      end
    end

    context 'when user does not exist' do
      it 'renders a not found error' do
        delete :destroy, params: { id: 0 }

        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
