class AddUserIdToTrainer < ActiveRecord::Migration[7.0]
  def change
    add_column :trainers, :user_id, :integer
  end
end
