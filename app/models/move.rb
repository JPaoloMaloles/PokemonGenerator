class Move < ApplicationRecord
  has_many :movesets
  has_many :pokemon, through: :movesets
end
