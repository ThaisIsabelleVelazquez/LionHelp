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

ActiveRecord::Schema[8.0].define(version: 2025_12_13_133317) do
  create_table "reviews", force: :cascade do |t|
    t.integer "vendor_id"
    t.text "vendor_name"
    t.text "title"
    t.integer "rating"
    t.text "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "client_id"
    t.string "reviewer"
    t.string "client_name"
  end

  create_table "service_requests", force: :cascade do |t|
    t.integer "client_id"
    t.integer "vendor_id"
    t.integer "service_id"
    t.string "status"
    t.text "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_service_requests_on_client_id"
    t.index ["service_id"], name: "index_service_requests_on_service_id"
    t.index ["vendor_id"], name: "index_service_requests_on_vendor_id"
  end

  create_table "services", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.decimal "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "vendor_id"
    t.string "vendor_name"
    t.string "category"
  end

  create_table "user_accounts", force: :cascade do |t|
    t.integer "user_id"
    t.string "name"
    t.string "email"
    t.string "password"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "service_requests", "services"
  add_foreign_key "service_requests", "user_accounts", column: "client_id"
  add_foreign_key "service_requests", "user_accounts", column: "vendor_id"
end
