class User < ApplicationRecord
  validates :username, presence: true
  validates :email, presence: true
  has_many :posts
  has_secure_password

  def self.search(search)
  where("username ILIKE ?", "%#{search}%")
  end
end
