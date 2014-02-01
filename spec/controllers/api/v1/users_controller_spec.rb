require 'spec_helper'

describe Api::V1::UsersController do
  include_context 'api_controller_context'

  describe 'POST #create' do
    let(:params){{}}
    
    context 'when succeed' do
      let!(:service) {UserCreationService.new(params)}
      let(:user) {stub_model User, id: 42, name: 'aabb', email: 'aa@b.com'}
      let(:access_token) {stub_model AccessToken, token: 'wololo'}  
      let(:sign_in_response) {SignInResponse.new(user, access_token)}

      before do
        UserCreationService.stub(:new).and_return(service)
        service.stub(:create).and_return(sign_in_response)
      end

      it 'respond_with 200' do
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
              token: access_token.token,
              token_type: 'bearer'
            }
          }
        expect(response.body).to eql(expected_response.to_json)
      end
    end

    context 'when failed' do
      it 'respond_with 422' do
        post :create, params
        expect(response.status).to eql(422)
      end
    end
  end

  describe 'GET #me' do
    it 'respond_with 200' do
      get :me
      expect(response.status).to eql(200)
    end

    it 'render current user' do
      get :me
      expected_response = 
        {
          id: 42,
          name: 'sam',
          email: 'sambya@aryasa.net'
        }
      expect(response.body).to include(expected_response.to_json)
    end
  end

  describe 'PUT #update' do
    let(:params){{}}
    before do
      current_user.stub(:update!)
    end

    it 'update current_user' do
      current_user.should_receive(:update!)
      put :update, params
    end

    it 'respond_with 200' do
      put :update, params
      expect(response.status).to eql(200)
    end

    it 'render updated user' do
      put :update, params
      expected_response = 
        {
          id: 42,
          name: 'sam',
          email: 'sambya@aryasa.net'
        }
      expect(response.body).to include(expected_response.to_json)
    end
  end
end
