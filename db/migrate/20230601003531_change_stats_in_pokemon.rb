class ChangeStatsInPokemon < ActiveRecord::Migration[7.0]
  def change
    change_column :pokemons, :hp, :integer
    change_column :pokemons, :atk, :integer
    change_column :pokemons, :defe, :integer
    change_column :pokemons, :spa, :integer
    change_column :pokemons, :spd, :integer
    change_column :pokemons, :spe, :integer
  end
end
