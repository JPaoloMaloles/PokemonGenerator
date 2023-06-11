class AddCurrentTrainerIdToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :current_trainer_id, :integer
  end
end
