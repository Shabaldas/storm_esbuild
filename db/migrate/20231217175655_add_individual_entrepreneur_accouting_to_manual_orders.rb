class AddIndividualEntrepreneurAccoutingToManualOrders < ActiveRecord::Migration[7.0]
  def change
    add_column :manual_orders, :individual_entrepreneur_accountings, :boolean, default: false
  end
end
