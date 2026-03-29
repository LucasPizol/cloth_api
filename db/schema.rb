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

  add_foreign_key "users", "shops"
end
