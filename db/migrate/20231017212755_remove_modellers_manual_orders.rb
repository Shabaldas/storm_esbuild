class RemoveModellersManualOrders < ActiveRecord::Migration[7.0]
  def change
    remove_column :manual_orders, :modeller
  end
end
