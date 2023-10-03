class CreatePrinters < ActiveRecord::Migration[7.0]
  def change
    create_table :printers do |t|
      t.integer :printer_code, null: false
      t.string :firm
      t.string :model
      t.integer :printing_technology, default: 0
      t.integer :state, default: 0
      t.integer :type_mechanic, default: 0
      t.string :table_size, null: false
      t.decimal :price_for_printer, precision: 8, scale: 2, default: 0.0, null: false
      t.datetime :bought
      t.string :comment
      t.string :by_for_upgrade

      t.timestamps
    end
  end
end
