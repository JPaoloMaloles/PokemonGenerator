class Team < ApplicationRecord
  belongs_to :trainer
  has_many :pokemon_in_teams
  has_many :unique_pokemons, through: :pokemon_in_teams
  has_many :pokemons, through: :unique_pokemons
end
