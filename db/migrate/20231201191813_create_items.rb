class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.string :image
      t.string :name
      t.string :effect

      t.timestamps
    end
  end
end
