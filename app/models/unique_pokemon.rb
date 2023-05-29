class UniquePokemon < ApplicationRecord
  belongs_to :pokemon
  belongs_to :user, optional: true
  # has_many :trainers, through: :users
  has_many :pokemon_in_teams
  has_many :teams, through: :pokemon_in_teams
  has_many :trainers, through: :teams
end
