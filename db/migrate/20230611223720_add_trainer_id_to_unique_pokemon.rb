class AddTrainerIdToUniquePokemon < ActiveRecord::Migration[7.0]
  def change
    add_column :unique_pokemons, :trainer_id, :integer
  end
end
