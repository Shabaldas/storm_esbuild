class AddModellerToManualOrder < ActiveRecord::Migration[7.0]
  def change
    add_column :manual_orders, :modeller, :string
  end
end
