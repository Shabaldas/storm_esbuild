class AddWorkflowStatusesToManualOrders < ActiveRecord::Migration[7.0]
  def change
    add_column :manual_orders, :workflow_status, :integer, default: 0
  end
end