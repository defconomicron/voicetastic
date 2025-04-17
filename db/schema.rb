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

ActiveRecord::Schema[8.0].define(version: 2025_04_16_155743) do
  create_table "messages", force: :cascade do |t|
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "nodes", force: :cascade do |t|
    t.string "number"
    t.string "long_name"
    t.string "short_name"
    t.string "macaddr"
    t.string "hw_model"
    t.string "node_id_from"
    t.text "nodeinfo_snapshot"
    t.text "user_snapshot"
    t.text "telemetry_snapshot"
    t.text "position_snapshot"
    t.text "device_metrics_snapshot"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "ignored_at"
  end

  create_table "variables", force: :cascade do |t|
    t.string "name"
    t.string "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_variables_on_name"
  end
end
