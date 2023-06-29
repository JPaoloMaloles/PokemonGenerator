class AddAbilityToUniquePokemons < ActiveRecord::Migration[7.0]
  def change
    add_column :unique_pokemons, :ability, :string
  end
end
