require 'spec_helper'

describe SessionCreationService do
  let!(:service) {SessionCreationService.new(username, password)}
  let(:username) {'sam@mail.com'}
  let(:password) {'password'}

  describe 'create' do
    context 'when succeed' do
      let(:user) {stub_model User, id: 42}
      let(:access_token) {stub_model AccessToken, token: 'wololo'}

      before do
        User.stub(:find_by).and_return(user)
        user.stub(:authenticate).and_return(true)
        AccessToken.stub(:issue_for).with(user).and_return(access_token)
      end

      it 'return the issued access_token' do
        expect(service.create).to eql(access_token)
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
