class CreateTrainers < ActiveRecord::Migration[7.0]
  def change
    create_table :trainers do |t|
      t.string :name
      t.string :title
      t.integer :level
      t.integer :experience

      t.timestamps
    end
  end
end
