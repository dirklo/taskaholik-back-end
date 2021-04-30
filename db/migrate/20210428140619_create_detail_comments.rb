class CreateDetailComments < ActiveRecord::Migration[6.1]
  def change
    create_table :detail_comments do |t|
      t.string :content
      t.integer :author_id
      t.integer :detail_id

      t.timestamps
    end
  end
end
