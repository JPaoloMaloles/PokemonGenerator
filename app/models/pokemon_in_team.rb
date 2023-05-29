class PokemonInTeam < ApplicationRecord
  belongs_to :team
  belongs_to :unique_pokemon
end
