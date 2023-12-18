class AddDescriptionAndEffectPercentToMoves < ActiveRecord::Migration[7.0]
  def change
    add_column :moves, :description, :string
    add_column :moves, :effect_percent, :integer
  end
end
