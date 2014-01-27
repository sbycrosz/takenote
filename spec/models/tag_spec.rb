require 'spec_helper'

describe Tag do
  describe 'Validation' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:user_id) }
  end

  describe 'Association' do
    it { should belong_to(:user) }
    it { should have_many(:notes) }
    it { should have_many(:note_tags) }
  end

  describe 'before_validation callback' do
    let(:tag) { stub_model Tag, name: 'UpperCase'}
    it 'should convert tag name to lowercase' do
      tag.valid?
      expect(tag.name).to eq('uppercase')
    end
  end

  describe 'self.fetch_or_create_all' do
    let(:tagnames){['existing_tag', 'new_tag']}
    let(:existing_tags){[existing_tag]}
    let(:existing_tag){stub_model Tag, name: 'existing_tag'}
    let(:new_tag){stub_model Tag, name: 'new_tag'}
    let(:expected_tags){[existing_tag, new_tag]}

    before do
      Tag.stub(:where).with(name: tagnames).and_return(existing_tags)
      Tag.stub(:create).with(name: 'new_tag').and_return(new_tag)
    end

    it 'do not re-create existing tag' do
      Tag.should_not_receive(:create).with(name: 'existing_tag')
      Tag.fetch_or_create_all(tagnames)
    end

    it 'create non-existing tag' do
      Tag.should_receive(:create).with(name: 'new_tag')
      Tag.fetch_or_create_all(tagnames)
    end

    it 'return an array of tag' do
      tags = Tag.fetch_or_create_all(tagnames)
      expect(tags).to eql(expected_tags)
    end
  end

  describe 'self.fetch_ids' do
    let(:tagnames){['tag', 'tag#2']}
    let(:tags){[tag, tag]}
    let(:tag){stub_model Tag, id: 42}

    before do
      Tag.stub(:where).with(name: tagnames).and_return(tags)
    end

    it 'return the ids of specified tagnames' do
      expect(Tag.fetch_ids(tagnames)).to eql([42, 42])
    end
  end
end
