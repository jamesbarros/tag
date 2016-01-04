class AddDetailsToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :accepted_by_user_id, :integer
    add_column :tasks, :task_status, :string
    add_column :tasks, :task_completed_at, :datetime
  end
end
