class CreateDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :details do |t|
      t.string :content
      t.integer :task_id
      t.boolean :completed, :default => false

      t.timestamps
    end
  end
end
