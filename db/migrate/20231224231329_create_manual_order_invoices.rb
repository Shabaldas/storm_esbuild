class CreateManualOrderInvoices < ActiveRecord::Migration[7.0]
  def change
    create_table :manual_order_invoices do |t|
      t.references :manual_order, null: false, foreign_key: true
      t.string :invoice_number
      t.date :date_of_issue
      t.date :due_date
      t.decimal :subtotal
      t.decimal :taxes
      t.decimal :discounts
      t.decimal :grand_total

      t.timestamps
    end
  end
end
