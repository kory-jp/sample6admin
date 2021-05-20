class CreatePosts < ActiveRecord::Migration[6.0]
  def up
    create_table :posts do |t|
      t.string :title, null: false
      t.text :body, null: false
      t.references :customer, null: false, foreign_key: true

      t.timestamps
    end
  end

  def down
    drop_table :posts
  end
end
