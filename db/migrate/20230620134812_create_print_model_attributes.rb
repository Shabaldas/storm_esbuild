class CreatePrintModelAttributes < ActiveRecord::Migration[7.0]
  def change
    create_table :print_model_attributes do |t|
      t.references :print_model, foreign_key: { on_delete: :cascade }
      t.string :color
      t.string :material
      t.string :quality
      t.decimal :subtotal_price, precision: 8, scale: 2, default: 0
      t.decimal :price, precision: 8, scale: 2, default: 0

      t.timestamps
    end
  end
end
