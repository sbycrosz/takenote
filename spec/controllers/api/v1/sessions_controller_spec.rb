require 'spec_helper'

describe Api::V1::SessionsController do
  include_context 'api_controller_context'

  let(:user) {stub_model User, id: 42, name: 'aabb', email: 'aa@b.com'}
  let(:access_token) {stub_model AccessToken, token: 'wololo'}
  let(:sign_in_response) {SignInResponse.new(user, access_token)}

  describe 'POST #create' do
    let(:params){{}}

    context 'when succeed' do
      before do
        SessionCreationService.any_instance.stub(:create).and_return(sign_in_response)
      end

      it 'render 200' do
        post :create, params
        expect(response.status).to eql(200)  
      end

      it 'render a sign_in_response object' do
        post :create, params
        expected_response = {
            user: {
                id: user.id,
                name: user.name,
                email: user.email
              },
            access_token: {
              access_token: access_token.token,
              token_type: 'bearer'
            }
          }
        expect(response.body).to eql(expected_response.to_json)
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
