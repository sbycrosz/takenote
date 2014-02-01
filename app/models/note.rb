class Note < ActiveRecord::Base
  include Taggable

  validates_presence_of :user_id
  
  belongs_to :user

  def self.create_welcome_notes
    welcome_notes.each do |welcome_note|
      self.create(welcome_note)
    end
  end

  private 
  
  def self.welcome_notes
    File.read("config/welcome_notes.json").tap do |json|
      return JSON.parse(json)
    end
  end
end
