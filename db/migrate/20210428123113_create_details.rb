class CreateDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :details do |t|
      t.string :content
      t.integer :task_id
      t.integer :creator_id
      t.boolean :completed, :default => false
      t.datetime :deadline, :optional

      t.timestamps
    end
  end
end
