class AddEvsAndIvsToUniquePokemon < ActiveRecord::Migration[7.0]
  def change
    add_column :unique_pokemons, :hp_ev, :integer
    add_column :unique_pokemons, :atk_ev, :integer
    add_column :unique_pokemons, :defe_ev, :integer
    add_column :unique_pokemons, :spa_ev, :integer
    add_column :unique_pokemons, :spd_ev, :integer
    add_column :unique_pokemons, :spe_ev, :integer
    add_column :unique_pokemons, :hp_iv, :integer
    add_column :unique_pokemons, :atk_iv, :integer
    add_column :unique_pokemons, :defe_iv, :integer
    add_column :unique_pokemons, :spa_iv, :integer
    add_column :unique_pokemons, :spd_iv, :integer
    add_column :unique_pokemons, :spe_iv, :integer
  end
end
