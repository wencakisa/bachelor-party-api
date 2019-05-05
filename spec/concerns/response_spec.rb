

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
  end

  before do
    routes.draw do
      get 'ok_action'    => 'anonymous#ok_action'
      get 'error_action' => 'anonymous#error_action'
    end
  end

  describe '#json_response' do
    before { get :ok_action }

    it 'returns json response with ok status' do
      expect(response).to be_truthy
      expect(response.status).to eq 200
    end
  end

  describe '#error_response' do
    before { get :error_action }

    it 'returns json response with error status' do
      expect(response.status).to eq 422
    end
  end
end
