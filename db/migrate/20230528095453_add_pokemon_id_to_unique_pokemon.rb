class AddPokemonIdToUniquePokemon < ActiveRecord::Migration[7.0]
  def change
    add_column :unique_pokemons, :pokemon_id, :integer
  end
end
