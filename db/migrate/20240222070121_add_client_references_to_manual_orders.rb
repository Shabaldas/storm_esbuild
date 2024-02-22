class AddClientReferencesToManualOrders < ActiveRecord::Migration[7.0]
  def change
    add_reference :manual_orders, :client, foreign_key: true
  end
end
