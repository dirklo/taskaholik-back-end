class CreatePrereqTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :prereq_tasks do |t|
      t.integer :task_id
      t.integer :requirement_id

      t.timestamps
    end
  end
end
