require 'spec_helper'

class Note
  attr_accessor :added_tags, :removed_tags, :new_tags, :tag_list
end

describe Taggable do
  let(:user){stub_model User, id: 132}
  let(:taggable){stub_model Note, id: 701, user: user}
  let(:tag_names){['tag#1', 'tag#2']}
  let(:tag1){stub_tag('tag#1', 1)}
  let(:tag2){stub_tag('tag#2', 2)}
  let(:tag_objects){[tag1, tag2]}
  let(:note_tags){taggable.note_tags}
  
  before do
    taggable.stub(:tag_objects).and_return(tag_objects)
  end

  describe 'after_save callback' do
    before do
      taggable.stub(:dirty?).and_return(dirty)
      taggable.stub(:save_tags)
    end

    context 'not dirty' do
      let(:dirty){false}
      it 'do not call save_tags' do
        taggable.should_not_receive(:save_tags)
        taggable.run_callbacks(:save)
      end
    end

    context 'dirty' do
      let(:dirty){true}
      it 'call save_tags' do
        taggable.should_receive(:save_tags)
        taggable.run_callbacks(:save)
      end
    end
  end

  describe 'tags' do
    it 'return list of tag names' do
      expect(taggable.tags).to eql(tag_names)
    end
  end

  describe 'tags=' do
    let(:new_tags) {['tag#1', 'new']}

    context 'taggable have previous tags' do
      context 'any_changes' do
        it 'should be marked as dirty' do
          taggable.tags = new_tags
          expect(taggable).to be_dirty  
        end

        it 'set added_tags' do
          taggable.tags = new_tags
          expect(taggable.added_tags).to eql(['new'])
        end

        it 'set removed_tags' do
          taggable.tags = new_tags
          expect(taggable.removed_tags).to eql(['tag#2'])
        end
      end

      context 'without changes' do
        let(:new_tags){tag_names}
        it 'should not be marked as dirty' do
          taggable.tags = new_tags
          expect(taggable).to_not be_dirty  
        end
      end
    end

    context 'taggable have no tags' do
      let(:tag_objects){[]}
      it 'should be marked as dirty' do
        taggable.tags = new_tags
        expect(taggable).to be_dirty  
      end

      it 'set new_tags as added_tags' do
        taggable.tags = new_tags
        expect(taggable.added_tags).to eql(new_tags)
      end
    end
  end

  describe 'save_tags' do
    let(:available_tags){[tag1, tag2, tag3]}
    let(:tag3){stub_tag('tag#3', 3)}

    before do
      Tag.stub(:where).with(user_id: user.id).and_return(available_tags)
    end

    context 'remove tags' do
      let(:removed_tags){[tag2]}
      let(:removed_tags_names){removed_tags.map(&:name)}
      let(:removed_tags_ids){removed_tags.map(&:id)}
      let(:taggable){stub_model Note, user: user, removed_tags: removed_tags_names}

      before do
        available_tags.stub(:fetch_ids).with(removed_tags_names).and_return(removed_tags_ids)
        note_tags.stub(:destroy_with_tag_ids)
      end

      it 'destroy association' do
        note_tags.should_receive(:destroy_with_tag_ids).with(removed_tags_ids)
        taggable.send(:save_tags)
      end
    end

    context 'add tags' do
      let(:added_tags){[tag3]}
      let(:added_tags_names){added_tags.map(&:name)}
      let(:taggable){stub_model Note, user: user, added_tags: added_tags_names}

      before do
        available_tags.stub(:fetch_or_create_all).with(added_tags_names).and_return(added_tags)
        tag_objects.stub(:<<)
      end

      it 'add tags association' do
        tag_objects.should_receive(:<<).with(added_tags)
        taggable.send(:save_tags)
      end
    end
  end

  def stub_tag(tagname, id)
    stub_model Tag, name: tagname, id: id
  end
end
