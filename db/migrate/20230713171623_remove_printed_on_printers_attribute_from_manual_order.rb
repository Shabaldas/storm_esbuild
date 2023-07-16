class RemovePrintedOnPrintersAttributeFromManualOrder < ActiveRecord::Migration[7.0]
  def change
    remove_column :manual_orders, :printed_on_printers
  end
end
