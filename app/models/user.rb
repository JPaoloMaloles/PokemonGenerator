class User < ApplicationRecord
  has_many :trainers
  has_many :teams, through: :trainers
  has_many :unique_pokemons, through: :trainers
  has_many :pokemons, through: :unique_pokemons
  has_secure_password
  validates :email, presence: true, uniqueness: true
end
