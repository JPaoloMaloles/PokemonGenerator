class RemovePositionsFromTeam < ActiveRecord::Migration[7.0]
  def change
    remove_column :teams, :position_one, :string
    remove_column :teams, :position_two, :string
    remove_column :teams, :position_three, :string
    remove_column :teams, :position_four, :string
    remove_column :teams, :position_five, :string
    remove_column :teams, :position_six, :string
  end
end
