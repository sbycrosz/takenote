require 'spec_helper'

describe Note do
  describe 'Validation' do
    it { should validate_presence_of(:user_id) }
  end

  describe 'Association' do
    it { should belong_to(:user) }
  end
end
