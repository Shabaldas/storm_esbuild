class CreateManualOrder < ActiveRecord::Migration[7.0]
  def change
    create_table :manual_orders do |t|
      t.string :print_code
      t.string :first_name
      t.string :last_name
      t.string :phone_number
      t.integer :app_contact, default: 0
      t.string :email
      t.decimal :price_for_modeling, precision: 8, scale: 2
      t.decimal :price_for_printing, precision: 8, scale: 2
      t.integer :count
      t.decimal :total_price, precision: 8, scale: 2
      t.integer :status, default: 0
      t.decimal :prepaid_expense, precision: 8, scale: 2
      t.string :print_material
      t.string :print_color
      t.string :printed_on_printers
      t.datetime :deadline
      t.string :printing_time_for_one_item
      t.text :comment

      t.timestamps
    end
  end
end
