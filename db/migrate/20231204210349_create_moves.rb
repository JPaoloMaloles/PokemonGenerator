class CreateMoves < ActiveRecord::Migration[7.0]
  def change
    create_table :moves do |t|
      t.string :name
      t.string :type
      t.string :category
      t.integer :pp
      t.integer :power
      t.integer :accuracy

      t.timestamps
    end
  end
end
