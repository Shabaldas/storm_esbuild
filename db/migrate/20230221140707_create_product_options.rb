class CreateProductOptions < ActiveRecord::Migration[7.0]
  def change
    create_table :product_options do |t|
      t.references :product, null: false, foreign_key: { on_delete: :cascade }
      t.references :option, null: false, foreign_key: { on_delete: :cascade }
      t.boolean :primary, default: false

      t.timestamps
    end

    add_index :product_options, %i[option_id product_id], unique: true
  end
end
