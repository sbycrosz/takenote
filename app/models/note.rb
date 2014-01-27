class Note < ActiveRecord::Base
  include Taggable

  validates_presence_of :user_id
  
  belongs_to :user
end
