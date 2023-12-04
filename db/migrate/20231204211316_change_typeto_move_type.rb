class ChangeTypetoMoveType < ActiveRecord::Migration[7.0]
  def change
    rename_column :moves, :type, :move_type
  end
end
