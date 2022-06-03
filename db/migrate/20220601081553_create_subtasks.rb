class CreateSubtasks < ActiveRecord::Migration[7.0]
  def change
    create_table :subtasks do |t|
      t.references :task, null: false, foreign_key: true
      t.string :description
      t.boolean :completed

      t.timestamps
    end
  end
end
