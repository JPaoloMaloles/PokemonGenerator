class RemoveEvAndIvFromUniquePokemon < ActiveRecord::Migration[7.0]
  def change
    remove_column :unique_pokemons, :ev, :integer
    remove_column :unique_pokemons, :iv, :integer
  end
end
