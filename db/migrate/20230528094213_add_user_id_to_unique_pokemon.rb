class AddUserIdToUniquePokemon < ActiveRecord::Migration[7.0]
  def change
    add_column :unique_pokemons, :user_id, :integer
  end
end
