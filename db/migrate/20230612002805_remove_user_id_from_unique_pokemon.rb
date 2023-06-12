class RemoveUserIdFromUniquePokemon < ActiveRecord::Migration[7.0]
  def change
    remove_column :unique_pokemons, :user_id, :integer
  end
end
