class User < ApplicationRecord
  has_many :trainers
  has_secure_password
  validates :email, presence: true, uniqueness: true
end
