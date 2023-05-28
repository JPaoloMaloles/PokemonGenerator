class CreateUniquePokemons < ActiveRecord::Migration[7.0]
  def change
    create_table :unique_pokemons do |t|
      t.string :nickname
      t.string :nature
      t.string :gender
      t.boolean :shiny
      t.integer :ev
      t.integer :iv

      t.timestamps
    end
  end
end
