require 'spec_helper'

describe Api::V1::SessionsController do
  include_context 'api_controller_context'

  let(:access_token) {stub_model AccessToken, token: 'wololo'}

  describe 'POST #create' do
    let(:params){{}}

    context 'when succeed' do
      before do
        SessionCreationService.any_instance.stub(:create).and_return(access_token)
      end

      it 'render 200' do
        post :create, params
        expect(response.status).to eql(200)  
      end

      it 'render an access_token' do
        post :create, params
        expected_response = 
            {
              access_token: 'wololo',
              token_type: 'bearer'
            }
        expect(response.body).to include(expected_response.to_json)
      end
    end

    context 'when failed' do
      before do
        SessionCreationService.any_instance.stub(:create).and_raise(Exceptions::AuthenticationFailed)
      end

      it 'respond_with 401' do
        post :create, params
        expect(response.status).to eql(401)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'respond_with 200' do
      delete :destroy
      expect(response.status).to eql(200)
    end

    it 'destroy the token' do
      doorkeeper_token.should_receive(:destroy)
      delete :destroy
    end
  end

end
