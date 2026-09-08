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

ActiveRecord::Schema[8.1].define(version: 2026_09_08_190112) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "bikes", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "customer_id", null: false
    t.string "model", null: false
    t.string "serial_number", null: false
    t.datetime "updated_at", null: false
    t.index ["serial_number"], name: "index_bikes_on_serial_number", unique: true
  end

  create_table "customers", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.string "phone", null: false
    t.datetime "updated_at", null: false
  end

  create_table "mechanics", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.datetime "updated_at", null: false
  end

  create_table "repair_line_items", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.decimal "price_charged", precision: 10, scale: 2, null: false
    t.integer "repair_id", null: false
    t.integer "service_item_id", null: false
    t.datetime "updated_at", null: false
  end

  create_table "repairs", force: :cascade do |t|
    t.integer "bike_id", null: false
    t.datetime "collected_at"
    t.datetime "created_at", null: false
    t.string "decision"
    t.datetime "dropped_off_at", null: false
    t.integer "mechanic_id"
    t.date "promised_on"
    t.string "status", default: "dropped_off", null: false
    t.datetime "updated_at", null: false
  end

  create_table "service_items", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.decimal "current_price", precision: 10, scale: 2, null: false
    t.string "name", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_service_items_on_name", unique: true
  end
end
