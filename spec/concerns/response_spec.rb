class ErrorObjects
  def full_messages
    {}
  end
end

class MockObject
  def errors
    ErrorObjects.new
  end
end

describe Response, type: :controller do
  controller(ApplicationController) do
    include Response

    def ok_action
      json_response MockObject.new
    end

    def error_action
      error_response MockObject.new
    end

    def not_found_action
      not_found
    end
  end

  before do
    routes.draw do
      get 'ok_action'        => 'anonymous#ok_action'
      get 'error_action'     => 'anonymous#error_action'
      get 'not_found_action' => 'anonymous#not_found_action'
    end
  end

  describe '#json_response' do
    before { get :ok_action }

    it 'returns json response with ok status' do
      expect(response).to be_truthy
      expect(response).to have_http_status(:ok)
    end
  end

  describe '#error_response' do
    before { get :error_action }

    it 'returns json response with error status' do
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe '#not_found' do
    before { get :not_found_action }

    it 'returns json response with not found error' do
      expect(response).to have_http_status(:not_found)
      expect(json_body['error']).to eq 'Not found'
    end
  end
end
