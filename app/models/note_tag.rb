class NoteTag < ActiveRecord::Base
  validates_presence_of :note_id, :tag_id  
  validates_uniqueness_of :tag_id, scope: :note_id  

  belongs_to :tag
  belongs_to :note

  scope :with_tag_id, -> (ids) {where(tag_id: ids)}

  def self.destroy_with_tag_ids(ids)
    self.with_tag_id(ids).destroy_all
  end
end
