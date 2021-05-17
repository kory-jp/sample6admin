class CreateCustomerEvents < ActiveRecord::Migration[6.0]
  def up
    create_table :customer_events do |t|
      t.references :customer, null: false, index: false, foreign_key: true
      t.string :type, null: false
      t.datetime :created_at, null: false
    end

    add_index :customer_events, :created_at
    add_index :customer_events, [:customer_id, :created_at]
  end

  def down
    drop_table :customer_events
  end
end
