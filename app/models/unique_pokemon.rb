class UniquePokemon < ApplicationRecord
  belongs_to :user, optional: true
  has_many :trainers, through: :users
  #has_many :pokemon
end
