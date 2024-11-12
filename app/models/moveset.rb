class Moveset < ApplicationRecord
  belongs_to :pokemon
  belongs_to :move
end
