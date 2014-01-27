require 'spec_helper'

describe NoteTag do
  describe 'Validation' do
    it { should validate_presence_of(:tag_id) }
    it { should validate_presence_of(:note_id) }
  end

  describe 'Association' do
    it { should belong_to(:note) }
    it { should belong_to(:tag) }
  end

  describe 'self.destroy_with_tag_ids' do
    let(:tag_ids) {[1, 2, 3]}
    let(:associations) {[note_tag, note_tag]}
    let(:note_tag) {stub_model NoteTag}
    
    before do
      NoteTag.stub(:where).with(tag_id: tag_ids).and_return(associations)
      associations.stub(:destroy_all)
    end

    it 'destroy associations with specific tag_id' do
      associations.should_receive(:destroy_all)
      NoteTag.destroy_with_tag_ids(tag_ids)
    end
  end
end
