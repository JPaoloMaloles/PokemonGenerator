class CreatePokemonInTeams < ActiveRecord::Migration[7.0]
  def change
    create_table :pokemon_in_teams do |t|
      t.integer :team_id
      t.integer :unique_pokemon_id

      t.timestamps
    end
  end
end
