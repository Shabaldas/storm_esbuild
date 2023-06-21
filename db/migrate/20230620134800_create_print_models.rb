class CreatePrintModels < ActiveRecord::Migration[7.0]
  def change
    create_table :print_models do |t|
      t.string :name
      t.string :size
      t.float :weight
      t.float :volume

      t.timestamps
    end
  end
end
