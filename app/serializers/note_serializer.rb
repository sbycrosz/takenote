class NoteSerializer < ActiveModel::Serializer
  attributes :id, :title, :content, :tags
end
