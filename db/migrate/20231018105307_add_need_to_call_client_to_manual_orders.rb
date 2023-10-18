class AddNeedToCallClientToManualOrders < ActiveRecord::Migration[7.0]
  def change
    add_column :manual_orders, :need_to_call_client, :boolean, default: false
  end
end
