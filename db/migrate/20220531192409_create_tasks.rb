class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.string :name
      t.text :description, :null => false
      t.date :deadline, :null => false
      t.boolean :completed
      t.integer :user_id
      t.integer :assignee_id, :null => false
      t.boolean :public

      t.timestamps
    end
  end
end
