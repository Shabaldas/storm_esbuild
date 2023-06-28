class AddOrderIdToCarts < ActiveRecord::Migration[7.0]
  def change
    add_reference :carts, :order, foreign_key: { on_delete: :cascade }
  end
end
