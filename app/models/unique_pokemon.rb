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
    return (((2 * Pokemon.find_by(id: pokemon_id).hp + hp_iv + ((hp_ev) / 4)) * level) / 100) * 1 + level + 10 # * 1 is the temporary nature multiplier
  end

  def determine_nature
    natures = [
      :Hardy,
      :Lonely,
      :Adamant,
      :Naughty,
      :Brave,

      :Bold,
      :Docile,
      :Impish,
      :Lax,
      :Relaxed,

      :Modest,
      :Mild,
      :Bashful,
      :Rash,
      :Quiet,

      :Calm,
      :Gentle,
      :Careful,
      :Quirky,
      :Sassy,

      :Timid,
      :Hasty,
      :Jolly,
      :Naive,
      :Serious,
    ]
    return natures.sample
  end

  def is_shiny
    if rand(1..4097) == 1
      return true
    else
      return false
    end
  end

  def other_stat_calculation(stat)
    calc = {
      hp: { base: Pokemon.find_by(id: pokemon_id).hp, iv: hp_iv, ev: hp_ev },
      atk: { base: Pokemon.find_by(id: pokemon_id).atk, iv: atk_iv, ev: atk_ev },
      defe: { base: Pokemon.find_by(id: pokemon_id).defe, iv: defe_iv, ev: defe_ev },
      spa: { base: Pokemon.find_by(id: pokemon_id).spa, iv: spa_iv, ev: spa_ev },
      spd: { base: Pokemon.find_by(id: pokemon_id).spd, iv: spd_iv, ev: spd_ev },
      spe: { base: Pokemon.find_by(id: pokemon_id).spe, iv: spe_iv, ev: spe_ev },
    }
    #need to add nature migration and have other_stat_calculation accept it as an argument
    nature = {
      Hardy: { atk: 1, defe: 1, spa: 1, spd: 1, spe: 1 },
      Lonely: { atk: 1.5, defe: 0.5, spa: 1, spd: 1, spe: 1 },
      Adamant: { atk: 1.5, defe: 1, spa: 0.5, spd: 1, spe: 1 },
      Naughty: { atk: 1.5, defe: 1, spa: 1, spd: 0.5, spe: 1 },
      Brave: { atk: 1.5, defe: 1, spa: 1, spd: 1, spe: 0.5 },

      Bold: { atk: 0.5, defe: 1.5, spa: 1, spd: 1, spe: 1 },
      Docile: { atk: 1, defe: 1, spa: 1, spd: 1, spe: 1 },
      Impish: { atk: 1, defe: 1.5, spa: 0.5, spd: 1, spe: 1 },
      Lax: { atk: 1, defe: 1.5, spa: 1, spd: 0.5, spe: 1 },
      Relaxed: { atk: 1, defe: 1.5, spa: 1, spd: 1, spe: 0.5 },

      Modest: { atk: 0.5, defe: 1, spa: 1.5, spd: 1, spe: 1 },
      Mild: { atk: 1, defe: 0.5, spa: 1.5, spd: 1, spe: 1 },
      Bashful: { atk: 1, defe: 1, spa: 1, spd: 1, spe: 1 },
      Rash: { atk: 1, defe: 1, spa: 1.5, spd: 0.5, spe: 1 },
      Quiet: { atk: 1, defe: 1, spa: 1.5, spd: 1, spe: 0.5 },

      Calm: { atk: 0.5, defe: 1, spa: 1, spd: 1.5, spe: 1 },
      Gentle: { atk: 1, defe: 0.5, spa: 1, spd: 1.5, spe: 1 },
      Careful: { atk: 1, defe: 1, spa: 0.5, spd: 1.5, spe: 1 },
      Quirky: { atk: 1, defe: 1, spa: 1, spd: 1, spe: 1 },
      Sassy: { atk: 1, defe: 1, spa: 1, spd: 1.5, spe: 0.5 },

      Timid: { atk: 0.5, defe: 1, spa: 1, spd: 1, spe: 1.5 },
      Hasty: { atk: 1, defe: 0.5, spa: 1, spd: 1, spe: 1.5 },
      Jolly: { atk: 1, defe: 1, spa: 0.5, spd: 1, spe: 1.5 },
      Naive: { atk: 1, defe: 1, spa: 1, spd: 0.5, spe: 1.5 },
      Serious: { atk: 1, defe: 1, spa: 1, spd: 1, spe: 1 },
    }
    nature_calc = 1
    # if nature[nature_stat][stat] > 1
    # elsif nature[nature_state][state] < 1
    # else
    #   nature_calc = 1
    # end
    if stat == :hp
      return (((2 * calc[stat][:base] + calc[stat][:iv] + ((calc[stat][:ev]) / 4)) * level) / 100) + level + 10
    else
      return (((((2 * calc[stat][:base] + calc[stat][:iv] + ((calc[stat][:ev]) / 4)) * level) / 100) + 5) * nature_calc)
    end
  end
end
