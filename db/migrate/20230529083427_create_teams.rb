class CreateTeams < ActiveRecord::Migration[7.0]
  def change
    create_table :teams do |t|
      t.integer :trainer_id
      t.string :name
      t.string :position_one
      t.string :position_two
      t.string :position_three
      t.string :position_four
      t.string :position_five
      t.string :position_six

      t.timestamps
    end
  end
end
