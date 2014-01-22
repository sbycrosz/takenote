class NoteSerializer < ActiveModel::Serializer
  attributes :id, :title, :content, :tags, :updated_at

  def updated_at
    object.updated_at.to_i
  end
end
