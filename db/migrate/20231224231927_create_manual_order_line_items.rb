class CreateManualOrderLineItems < ActiveRecord::Migration[7.0]
  def change
    create_table :manual_order_line_items do |t|
      t.references :manual_order_invoice, null: false, foreign_key: true
      t.string :item
      t.integer :count
      t.decimal :price

      t.timestamps
    end
  end
end
