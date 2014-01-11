require 'spec_helper'

describe AccessToken do
  describe 'issue_for' do
    let(:access_token) {stub_model AccessToken, token: 'wololo'}
    let(:user) {stub_model User, id: 4242}

    before do
      AccessToken.stub_chain(:where, :first_or_create).and_return(access_token)
      access_token.stub(:expired?).and_return(false)
    end

    context 'Service instantiated with user object' do
      context 'Token is expired' do
        before do
          access_token.stub(:expired?).and_return(true)
        end

        it 'updates the token' do
          access_token.should_receive(:update)
          AccessToken.issue_for(user)
        end
      end      

      it 'return access_token' do
        expect(AccessToken.issue_for(user)).to eq(access_token)
      end
    end        
  end
end
