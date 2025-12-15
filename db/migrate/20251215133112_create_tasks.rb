class CreateTasks < ActiveRecord::Migration[8.0]
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :desription
      t.date :due_date
      t.string :status

      t.timestamps
    end
  end
end
