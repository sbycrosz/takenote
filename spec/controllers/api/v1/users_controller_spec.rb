require 'spec_helper'

describe Api::V1::UsersController do
  include_context 'api_controller_context'

  describe 'POST #create' do
    let(:params){{}}
    
    context 'when succeed' do
      let(:created_user){stub_model User, id: 42, email: "aa@b.com", name: 'aabb'}
      before do
        User.stub(:create!).and_return(created_user)
      end

      it 'respond_with 200' do
        post :create, params
        expect(response.status).to eql(200)
      end

      it 'render newly created user' do
        post :create, params
        expected_response = 
          {
            id: 42,
            name: 'aabb',
            email: 'aa@b.com'
          }
        expect(response.body).to include(expected_response.to_json)
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
end
