class ChangePrinterCodeFromIntegerToStringInPrinter < ActiveRecord::Migration[7.0]
  def change
    change_column :printers, :printer_code, :string, null: true
    change_column :printers, :table_size, :string, null: true
    change_column :printers, :price_for_printer, :decimal, precision: 8, scale: 2, default: 0.0, null: true
  end
end
