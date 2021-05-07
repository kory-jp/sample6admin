class CreateCustomers < ActiveRecord::Migration[6.0]
  def up
    create_table :customers do |t|
      t.string :email, null: false
      t.string :name, null: false
      t.string :nickname
      t.string :hashed_password
      t.boolean :suspended, null: false, default: false
      t.text :introduction
      t.text :image_data

      t.timestamps
    end
    add_index :customers, :email, unique: true
    add_index :customers, :nickname, unique: true
  end

  def down
    drop_table :customers
  end
end
