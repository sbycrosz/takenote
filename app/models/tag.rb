class Tag < ActiveRecord::Base
  validates_presence_of :name, :user_id
  validates_uniqueness_of :name, scope: :user_id

  belongs_to :user
  has_many :note_tags, dependent: :destroy
  has_many :notes, through: :note_tags

  before_validation :force_lowercase

  scope :named, -> (name) {where(name: name)}

  def self.fetch_or_create_all(tagnames)
    existing_tags = self.named(tagnames).to_a   
    
    tagnames.map do |tagname|
      existing_tag = existing_tags.detect{ |tag| tag.name == tagname}
      existing_tag || self.create(name: tagname)
    end
  end

  def self.fetch_ids(tagnames)
    self.named(tagnames).map(&:id)
  end

  private

  def force_lowercase
    name.downcase! if name.present?
  end
end
