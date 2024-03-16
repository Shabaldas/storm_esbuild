class AddWorkerReferencesToManualOrders < ActiveRecord::Migration[7.0]
  def change
    add_reference :manual_orders, :worker, foreign_key: true
  end
end
