class RenameDesriptionToDescriptionInTasks < ActiveRecord::Migration[8.0]
  def change
  rename_column :tasks, :desription, :description
  end
end
