require 'spec_helper'

describe UserCreationService do
  let(:service) {UserCreationService.new(user_params)}
  
  describe 'create' do    
    let(:user) {stub_model User, id: 42, name: 'aabb', email: 'aa@b.com'}
    let(:user_params) {stub_model Hash}
    let(:access_token) {stub_model AccessToken, token: 'wololo'}

    before do
      User.stub(:create!).and_return(user)
      AccessToken.stub(:issue_for).with(user).and_return(access_token)
    end

    it 'return proper SignInResponse object' do
      service.create.tap do |sign_in_response|
        expect(sign_in_response.user).to eql(user)
        expect(sign_in_response.access_token).to eql(access_token)
      end
    end
  end
end
