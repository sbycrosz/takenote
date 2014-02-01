require 'spec_helper'

describe User do
  describe 'Validation' do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:name) }

    describe 'validates_old_password' do
      let(:user) { stub_model User, id: 43}
      it 'validates old_password when updating password' do
        user.update(password: '12345', password_confirmation: '12345')
        expect(user.errors[:old_password]).to_not be_empty
      end
    end
  end

  describe 'Association' do
    it { should have_many(:notes) }
    it { should have_many(:tags) }
  end

  describe 'create_default_notes' do
    let(:user) {stub_model User, id: 43}
    let(:notes) {user.notes}
    
    before do
      notes.stub(:create_default_notes)
    end

    it 'delegate create_welcome_notes to notes' do
      notes.should_receive(:create_welcome_notes)
      user.create_welcome_notes
    end
  end
end
