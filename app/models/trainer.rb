class Trainer < ApplicationRecord
  belongs_to :user, optional: true
  has_many :unique_pokemon, through: :users
end
