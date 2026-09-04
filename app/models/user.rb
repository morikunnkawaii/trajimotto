class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy

  validates :email_address, presence: true
  validates :name, presence: true

  normalizes :email_address, with: ->(e) { e.strip.downcase }
  
  has_many :posts, dependent: :destroy
end
