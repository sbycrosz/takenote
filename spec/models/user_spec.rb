require 'spec_helper'

describe User do
  describe 'Validation' do
    context 'creation' do
      context 'guest user' do
        let(:user) { stub_model User, guest: true}
        
        it 'do not validates presence of email' do
          user.save
          expect(user.errors[:email]).to be_empty
        end 

        it 'do not validates presence of name' do
          user.save
          expect(user.errors[:name]).to be_empty
        end

        it 'do not validates presence of password' do
          user.save
          expect(user.errors[:password]).to be_empty
        end
      end

      context 'normal user' do
        let(:user) { stub_model User }
        
        it 'validates presence of email' do
          user.save
          expect(user.errors[:email]).to_not be_empty
        end 

        it 'validates presence of name' do
          user.save
          expect(user.errors[:name]).to_not be_empty
        end

        it 'validates presence of password' do
          user.save
          expect(user.errors[:password]).to_not be_empty
        end
      end
    end


    context 'update' do
      context 'normal user' do
        let(:user) { stub_model User, id: 43}
        it 'validates old_password when updating password' do
          user.update(password: '12345', password_confirmation: '12345')
          expect(user.errors[:old_password]).to_not be_empty
        end
      end

      context 'guest user' do
        let(:user) { stub_model User, id: 43, guest: true}
        it 'do not validates old_password when updating password' do
          user.update(password: '12345', password_confirmation: '12345')
          expect(user.errors[:old_password]).to be_empty
        end
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

  describe 'create_guest_account' do
    let(:user) {stub_model User, id: 43}
    
    before do
      User.stub(:create!)
    end

    it 'create an user with correct parameter' do
      expected_params = {guest: true}
      User.should_receive(:create!).with(expected_params)
      User.create_guest_account
    end
  end
end
