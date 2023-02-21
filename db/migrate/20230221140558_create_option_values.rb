class CreateOptionValues < ActiveRecord::Migration[7.0]
  def change
    create_table :option_values do |t|
      t.references :option, null: false, foreign_key: { on_delete: :cascade }
      t.string :value

      t.timestamps
    end
  end
end
