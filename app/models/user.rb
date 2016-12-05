class User < ApplicationRecord
  validates :username, presence: true
  validates :email, presence: true
  has_many :posts
  validates_uniqueness_of :username
  has_secure_password
end
