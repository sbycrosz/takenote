class User < ActiveRecord::Base
  attr_accessor :old_password

  has_secure_password

  validates_presence_of :name, :email
  validates_uniqueness_of :email
  validate :validates_old_password, on: :update

  has_many :notes
  has_many :tags

  delegate :create_welcome_notes, to: :notes
  private

  def validates_old_password
    errors.add(:old_password, "is incorrect") if password.present? && !authenticate(old_password)
  end
end
