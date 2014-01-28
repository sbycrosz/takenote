class User < ActiveRecord::Base
  attr_accessor :old_password

  has_secure_password validations: false

  validates_presence_of :password, unless: :guest?
  validates_presence_of :password_confirmation, if: :password_present?
  validates_confirmation_of :password, if: :password_present?

  validates_presence_of :name, :email, unless: :guest?
  validates_uniqueness_of :email, unless: :guest?
  validate :validates_old_password, on: :update, unless: :guest?

  has_many :notes
  has_many :tags

  delegate :create_welcome_notes, to: :notes
  private

  def validates_old_password
    errors.add(:old_password, "is incorrect") if password.present? && !authenticate(old_password)
  end

  def self.create_guest_account
    create!(guest: true)
  end

  def password_present?
    password.present?
  end
end
