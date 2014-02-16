require 'spec_helper'

describe UserCreationService do
  describe 'create' do    
    let(:service) {UserCreationService.new(user_params)}
    let(:user) {stub_model User, id: 42, name: 'aabb', email: 'aa@b.com'}
    let(:user_params) {stub_model Hash}
    let(:access_token) {stub_model AccessToken, token: 'wololo'}

    before do
      User.stub(:create!).and_return(user)
      AccessToken.stub(:issue_for).with(user).and_return(access_token)
      user.stub(:create_welcome_notes)
    end

    it 'create proper welcome note' do
      user.should_receive(:create_welcome_notes)
      service.create
    end

    it 'return proper SignInResponse object' do
      service.create.tap do |sign_in_response|
        expect(sign_in_response.user).to eql(user)
        expect(sign_in_response.access_token).to eql(access_token)
      end
    end
  end

  describe 'create_guest_account' do    
    let(:service) {UserCreationService.new}
    let(:user) {stub_model User, id: 42, name: 'aabb', email: 'aa@b.com'}
    let(:access_token) {stub_model AccessToken, token: 'wololo'}

    before do
      User.stub(:create_guest_account).and_return(user)
      AccessToken.stub(:issue_for).with(user).and_return(access_token)
      user.stub(:create_welcome_notes)
    end

    it 'create proper welcome note' do
      user.should_receive(:create_welcome_notes)
      service.create_guest_account
    end

    it 'return proper SignInResponse object' do
      service.create_guest_account.tap do |sign_in_response|
        expect(sign_in_response.user).to eql(user)
        expect(sign_in_response.access_token).to eql(access_token)
      end
    end
  end
end
