class AddEndDateToManualOrders < ActiveRecord::Migration[7.0]
  def change
    add_column :manual_orders, :end_date, :date
  end
end
