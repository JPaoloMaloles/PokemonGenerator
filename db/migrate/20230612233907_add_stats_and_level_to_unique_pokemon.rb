class AddStatsAndLevelToUniquePokemon < ActiveRecord::Migration[7.0]
  def change
    add_column :unique_pokemons, :level, :integer
    add_column :unique_pokemons, :hp, :integer
    add_column :unique_pokemons, :atk, :integer
    add_column :unique_pokemons, :defe, :integer
    add_column :unique_pokemons, :spa, :integer
    add_column :unique_pokemons, :spd, :integer
    add_column :unique_pokemons, :spe, :integer
  end
end
