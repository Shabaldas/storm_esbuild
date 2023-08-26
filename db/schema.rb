# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_08_20_144901) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "cart_item_option_values", force: :cascade do |t|
    t.bigint "cart_item_id"
    t.bigint "product_option_value_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cart_item_id"], name: "index_cart_item_option_values_on_cart_item_id"
    t.index ["product_option_value_id"], name: "index_cart_item_option_values_on_product_option_value_id"
  end

  create_table "cart_items", force: :cascade do |t|
    t.bigint "cart_id", null: false
    t.string "cartable_type", null: false
    t.bigint "cartable_id", null: false
    t.integer "quantity", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cart_id"], name: "index_cart_items_on_cart_id"
    t.index ["cartable_type", "cartable_id"], name: "index_cart_items_on_cartable"
  end

  create_table "carts", force: :cascade do |t|
    t.string "token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "order_id"
    t.index ["order_id"], name: "index_carts_on_order_id"
    t.index ["token"], name: "index_carts_on_token", unique: true
  end

  create_table "cities", force: :cascade do |t|
    t.string "english_name", null: false
    t.string "ukrainian_name", null: false
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "feedback_calls", force: :cascade do |t|
    t.string "phone_number", null: false
    t.boolean "processed", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "manual_orders", force: :cascade do |t|
    t.string "print_code"
    t.string "first_name"
    t.string "last_name"
    t.string "phone_number"
    t.integer "app_contact", default: 0
    t.string "email"
    t.decimal "price_for_modeling", precision: 8, scale: 2
    t.decimal "price_for_printing", precision: 8, scale: 2
    t.integer "count"
    t.decimal "total_price", precision: 8, scale: 2
    t.integer "status", default: 0
    t.decimal "prepaid_expense", precision: 8, scale: 2
    t.string "print_material"
    t.string "print_color"
    t.datetime "deadline"
    t.string "printing_time_for_one_item"
    t.text "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "quality"
    t.string "infill"
  end

  create_table "modeling_orders", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "phone_number"
    t.string "email"
    t.string "link_to_model"
    t.integer "status", default: 0
    t.decimal "total_price", precision: 8, scale: 2
    t.datetime "deadline"
    t.text "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "option_values", force: :cascade do |t|
    t.bigint "option_id", null: false
    t.string "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["option_id"], name: "index_option_values_on_option_id"
  end

  create_table "options", force: :cascade do |t|
    t.string "title"
    t.integer "measurement"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "orders", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "phone"
    t.string "email"
    t.integer "status", default: 0
    t.decimal "subtotal", precision: 8, scale: 2
    t.decimal "total", precision: 8, scale: 2
    t.text "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "print_model_attributes", force: :cascade do |t|
    t.bigint "print_model_id"
    t.string "color"
    t.string "material"
    t.string "quality"
    t.decimal "subtotal_price", precision: 8, scale: 2, default: "0.0"
    t.decimal "price", precision: 8, scale: 2, default: "0.0"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["print_model_id"], name: "index_print_model_attributes_on_print_model_id"
  end

  create_table "print_models", force: :cascade do |t|
    t.string "name"
    t.string "size"
    t.float "weight"
    t.float "volume"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "printer_maintenances", force: :cascade do |t|
    t.bigint "printer_id", null: false
    t.string "problem", null: false
    t.datetime "problem_find"
    t.string "time_for_fix"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["printer_id"], name: "index_printer_maintenances_on_printer_id"
  end

  create_table "printers", force: :cascade do |t|
    t.string "printer_code"
    t.string "firm"
    t.string "model"
    t.integer "printing_technology", default: 0
    t.integer "state", default: 0
    t.integer "type_mechanic", default: 0
    t.string "table_size"
    t.decimal "price_for_printer", precision: 8, scale: 2, default: "0.0"
    t.datetime "bought"
    t.string "comment"
    t.string "by_for_upgrade"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "printing_orders", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "phone_number"
    t.string "email"
    t.string "link_to_model"
    t.integer "status", default: 0
    t.decimal "total_price", precision: 8, scale: 2
    t.datetime "deadline"
    t.text "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "product_categories", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "ancestry"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ancestry"], name: "index_product_categories_on_ancestry"
  end

  create_table "product_option_values", force: :cascade do |t|
    t.bigint "product_option_id", null: false
    t.bigint "option_value_id", null: false
    t.decimal "price", precision: 8, scale: 2, default: "0.0", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["option_value_id"], name: "index_product_option_values_on_option_value_id"
    t.index ["product_option_id"], name: "index_product_option_values_on_product_option_id"
  end

  create_table "product_options", force: :cascade do |t|
    t.bigint "product_id", null: false
    t.bigint "option_id", null: false
    t.boolean "primary", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["option_id", "product_id"], name: "index_product_options_on_option_id_and_product_id", unique: true
    t.index ["option_id"], name: "index_product_options_on_option_id"
    t.index ["product_id"], name: "index_product_options_on_product_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.bigint "product_category_id", null: false
    t.integer "status", default: 0
    t.decimal "price", precision: 8, scale: 2, default: "0.0", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_products_on_name"
    t.index ["product_category_id"], name: "index_products_on_product_category_id"
  end

  create_table "rendering_orders", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "phone_number"
    t.string "email"
    t.string "link_to_model"
    t.integer "status", default: 0
    t.decimal "total_price", precision: 8, scale: 2
    t.datetime "deadline"
    t.text "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "role", default: 0
    t.string "first_name"
    t.string "last_name"
    t.string "phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "provider"
    t.string "uid"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "cart_item_option_values", "cart_items", on_delete: :cascade
  add_foreign_key "cart_item_option_values", "product_option_values", on_delete: :cascade
  add_foreign_key "cart_items", "carts"
  add_foreign_key "carts", "orders", on_delete: :cascade
  add_foreign_key "option_values", "options", on_delete: :cascade
  add_foreign_key "print_model_attributes", "print_models", on_delete: :cascade
  add_foreign_key "product_option_values", "option_values", on_delete: :cascade
  add_foreign_key "product_option_values", "product_options", on_delete: :cascade
  add_foreign_key "product_options", "options", on_delete: :cascade
  add_foreign_key "product_options", "products", on_delete: :cascade
  add_foreign_key "products", "product_categories", on_delete: :cascade
end
