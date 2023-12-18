class CreateMovesets < ActiveRecord::Migration[7.0]
  def change
    create_table :movesets do |t|
      t.string :pokemon_name
      t.string :move_name
      t.string :level_acquire
      t.integer :pokemon_id
      t.integer :move_id

      t.timestamps
    end
  end
end
