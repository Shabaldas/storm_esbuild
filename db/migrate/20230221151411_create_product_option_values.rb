class CreateProductOptionValues < ActiveRecord::Migration[7.0]
  def change
    create_table :product_option_values do |t|
      t.references :product_option, null: false, foreign_key: { on_delete: :cascade }
      t.references :option_value, null: false, foreign_key: { on_delete: :cascade }
      t.decimal :price, precision: 8, scale: 2, default: 0.0, null: false

      t.timestamps
    end
  end
end
