class CreateCartItemOptionValues < ActiveRecord::Migration[7.0]
  def change
    create_table :cart_item_option_values do |t|
      t.references :cart_item, foreign_key: { on_delete: :cascade }
      t.references :product_option_value, foreign_key: { on_delete: :cascade }

      t.timestamps
    end
  end
end
