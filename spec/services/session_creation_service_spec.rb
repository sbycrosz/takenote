require 'spec_helper'

describe SessionCreationService do
  let(:service) {SessionCreationService.new(username, password)}
  let(:username) {'sam@mail.com'}
  let(:password) {'password'}

  describe 'create' do
    context 'when succeed' do
      let(:user) {stub_model User, id: 42}
      let(:access_token) {stub_model AccessToken, token: 'wololo'}
      let!(:sign_in_response) {SignInResponse.new(user, access_token)}

      before do
        User.stub(:find_by).and_return(user)
        user.stub(:authenticate).and_return(true)
        AccessToken.stub(:issue_for).with(user).and_return(access_token)
        SignInResponse.stub(:new).with(user, access_token).and_return(sign_in_response)
      end

      it 'return a sign_in_response object' do
        expect(service.create).to eql(sign_in_response)
      end
    end

    context 'when failed' do
      before do
        User.stub(:find_by).and_return(nil)
      end

      it 'raise AuthenticationFailed' do
        expect{service.create}.to raise_error(Exceptions::AuthenticationFailed)
      end
    end
  end
end
