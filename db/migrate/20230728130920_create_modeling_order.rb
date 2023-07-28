class CreateModelingOrder < ActiveRecord::Migration[7.0]
  def change
    create_table :modeling_orders do |t|
      t.string :first_name
      t.string :last_name
      t.string :phone_number
      t.string :email
      t.string :link_to_model
      t.integer :status, default: 0
      t.decimal :total_price, precision: 8, scale: 2
      t.datetime :deadline
      t.text :comment

      t.timestamps
    end
  end
end
