module Taggable
  extend ActiveSupport::Concern
  included do
    after_save :save_tags, if: :dirty?
    has_many :note_tags, dependent: :destroy
    has_many :tag_objects, source: :tag, through: :note_tags
    scope :include_tags, -> { includes(:tag_objects).includes(:note_tags) }
  end

  def tags
    @tag_list ||= tag_objects.map(&:name)
  end

  def tags=(new_tags)
    @new_tags = new_tags
    if tags.present?
      @added_tags = @new_tags - tags
      @removed_tags = tags - @new_tags
    else
      @added_tags = @new_tags
    end
    @new_tags
  end

  private

  def dirty?
    @added_tags.present? || @removed_tags.present?
  end

  def save_tags
    @available_tags = Tag.where(user_id: user_id)  
    add_tag_objects if @added_tags.present?
    remove_tag_objects if @removed_tags.present?
    @tag_list = @new_tags  
  end

  def add_tag_objects
    @available_tags.fetch_or_create_all(@added_tags).tap do |added_tag_objects|
      tag_objects << added_tag_objects
    end
  end

  def remove_tag_objects
    @available_tags.fetch_ids(@removed_tags).tap do |removed_tag_ids|
      note_tags.destroy_with_tag_ids(removed_tag_ids)
    end
  end
end
