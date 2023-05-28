class UniquePokemon < ApplicationRecord
  belongs_to :pokemon
  belongs_to :user, optional: true
  has_many :trainers, through: :users
end
