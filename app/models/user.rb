class User < ApplicationRecord
  validates :username, presence: true
  validates :email, presence: true
  validates :password, presence: true
  validates :password_confirmation, presence: true, :on => :create
  has_many :posts
  has_secure_password
end
