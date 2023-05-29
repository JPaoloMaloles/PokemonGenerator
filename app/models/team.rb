class Team < ApplicationRecord
  belongs_to :trainer
  has_many :pokemon_in_teams
  has_many :unique_pokemon, through: :pokemon_in_teams
end
