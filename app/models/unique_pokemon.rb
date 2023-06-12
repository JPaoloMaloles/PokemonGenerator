class UniquePokemon < ApplicationRecord
  belongs_to :pokemon
  # belongs_to :user, optional: true
  # has_many :trainers, through: :users
  belongs_to :trainer
  has_many :pokemon_in_teams
  has_many :teams, through: :pokemon_in_teams

  def hp_calculation
    # natures = []
    # if natures.include(nature)
    # elsif
    # else
    # end
    return (((2 * Pokemon.find_by(id: pokemon_id).hp + hp_iv + ((hp_ev) / 4) * level) / 100) * 1.5) + level + 10
  end

  # def other_stat_calculation(stat)
  #   return ((2 * stat + stat.iv + ((stat.ev) / 4) * level) / 100) * nature
  # end
end
