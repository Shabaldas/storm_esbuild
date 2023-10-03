class CreatePrinterMaintenances < ActiveRecord::Migration[7.0]
  def change
    create_table :printer_maintenances do |t|
      t.references :printer, null: false
      t.string :problem, null: false
      t.datetime :problem_find
      t.string :time_for_fix

      t.timestamps
    end
  end
end
