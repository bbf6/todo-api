class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.text :name, limit: 1000, null: false
      t.datetime :due_date
      t.boolean :is_completed, default: false, null: false
      t.timestamps
    end
  end
end
