class CreateProjects < ActiveRecord::Migration[6.1]
  def change
    create_table :projects do |t|
      t.string :title
      t.integer :creator_id
      t.integer :team_id
      t.datetime :deadline

      t.timestamps
    end
  end
end
