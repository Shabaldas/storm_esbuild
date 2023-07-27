class AddQualityAndInfillToManualOrders < ActiveRecord::Migration[7.0]
  def change
    add_column :manual_orders, :quality, :string
    add_column :manual_orders, :infill, :string
  end
end
