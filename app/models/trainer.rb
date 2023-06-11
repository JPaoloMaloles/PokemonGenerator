class Trainer < ApplicationRecord
  belongs_to :user, optional: true
  has_many :teams
  has_many :unique_pokemons
end
