class Pokemon < ApplicationRecord
  has_many :unique_pokemons
  has_many :movesets
end
