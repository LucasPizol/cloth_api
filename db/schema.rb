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

ActiveRecord::Schema[8.1].define(version: 2026_03_29_020654) do
  create_table "addresses", force: :cascade do |t|
    t.string "city"
    t.string "complement"
    t.string "country"
    t.datetime "created_at", null: false
    t.string "neighborhood"
    t.string "number"
    t.integer "owner_id", null: false
    t.string "owner_type", null: false
    t.string "state"
    t.string "street"
    t.datetime "updated_at", null: false
    t.string "zipcode"
    t.index ["owner_type", "owner_id"], name: "index_addresses_on_owner"
  end

  create_table "item_option_values", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "item_option_id", null: false
    t.integer "position", default: 0, null: false
    t.datetime "updated_at", null: false
    t.string "value", null: false
    t.index ["item_option_id", "position"], name: "index_item_option_values_on_item_option_id_and_position"
    t.index ["item_option_id", "value"], name: "index_item_option_values_on_item_option_id_and_value", unique: true
    t.index ["item_option_id"], name: "index_item_option_values_on_item_option_id"
  end

  create_table "item_options", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "item_id", null: false
    t.string "name", null: false
    t.integer "position", default: 0, null: false
    t.datetime "updated_at", null: false
    t.index ["item_id", "name"], name: "index_item_options_on_item_id_and_name", unique: true
    t.index ["item_id", "position"], name: "index_item_options_on_item_id_and_position"
    t.index ["item_id"], name: "index_item_options_on_item_id"
  end

  create_table "item_variant_option_values", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "item_option_value_id", null: false
    t.integer "item_variant_id", null: false
    t.datetime "updated_at", null: false
    t.index ["item_option_value_id"], name: "index_item_variant_option_values_on_item_option_value_id"
    t.index ["item_variant_id", "item_option_value_id"], name: "index_variant_option_values_uniqueness", unique: true
    t.index ["item_variant_id"], name: "index_item_variant_option_values_on_item_variant_id"
  end

  create_table "item_variants", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "item_id", null: false
    t.integer "price_cents", default: 0, null: false
    t.string "price_currency", default: "BRL", null: false
    t.string "sku"
    t.integer "stock_quantity", default: 0, null: false
    t.boolean "track_inventory", default: true, null: false
    t.datetime "updated_at", null: false
    t.index ["item_id"], name: "index_item_variants_on_item_id"
    t.index ["sku"], name: "index_item_variants_on_sku", unique: true, where: "sku IS NOT NULL"
  end

  create_table "items", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.text "description"
    t.string "name", null: false
    t.integer "shop_id", null: false
    t.string "status", default: "draft", null: false
    t.datetime "updated_at", null: false
    t.index ["shop_id", "name"], name: "index_items_on_shop_id_and_name"
    t.index ["shop_id"], name: "index_items_on_shop_id"
  end

  create_table "shops", force: :cascade do |t|
    t.string "cnpj", null: false
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.datetime "updated_at", null: false
    t.index ["cnpj"], name: "index_shops_on_cnpj", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "cellphone"
    t.datetime "created_at", null: false
    t.string "email"
    t.string "name"
    t.string "password_digest", null: false
    t.integer "shop_id", null: false
    t.datetime "updated_at", null: false
    t.index ["cellphone"], name: "index_users_on_cellphone", unique: true, where: "cellphone IS NOT NULL"
    t.index ["email"], name: "index_users_on_email", unique: true, where: "email IS NOT NULL"
    t.index ["shop_id"], name: "index_users_on_shop_id"
  end

  add_foreign_key "item_option_values", "item_options"
  add_foreign_key "item_options", "items"
  add_foreign_key "item_variant_option_values", "item_option_values"
  add_foreign_key "item_variant_option_values", "item_variants"
  add_foreign_key "item_variants", "items"
  add_foreign_key "items", "shops"
  add_foreign_key "users", "shops"
end
