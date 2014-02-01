require 'spec_helper'

describe Note do
  describe 'Validation' do
    it { should validate_presence_of(:user_id) }
  end

  describe 'Association' do
    it { should belong_to(:user) }
    it { should have_many(:tag_objects) }
    it { should have_many(:note_tags) }
  end

  describe '.create_welcome_notes' do
    let(:welcome_notes){[welcome_note_1, welcome_note_2]}
    let(:welcome_note_1){{title: 'first'}}
    let(:welcome_note_2){{title: 'second'}}

    before do
      Note.stub(:create)
      Note.stub(:welcome_notes).and_return(welcome_notes)
    end

    it 'create a welcome note' do
      Note.should_receive(:create).with(welcome_note_1)
      Note.should_receive(:create).with(welcome_note_2)
      Note.create_welcome_notes
    end
  end

  describe '.welcome_notes' do
    let(:welcome_notes_string){'somestring'}
    let(:welcome_notes_parsed){{some: 'hash'}}

    before do
      File.stub(:read).and_return(welcome_notes_string)
      JSON.stub(:parse).with(welcome_notes_string).and_return(welcome_notes_parsed)
    end

    it 'return parsed welcome_notes file' do
      expect(Note.welcome_notes).to eql(welcome_notes_parsed)
    end
  end
end
