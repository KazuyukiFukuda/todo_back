class ChangeColumnToNull < ActiveRecord::Migration[7.0]
  def up
    change_column_null :tasks, :assignee_id,  true
    change_column_null :tasks, :description,  true
    change_column_null :tasks, :deadline,     true
  end
  def down
    change_column_null :tasks, :assignee_id,  false
    change_column_null :tasks, :description,  false
    change_column_null :tasks, :deadline,     false
  end
end
