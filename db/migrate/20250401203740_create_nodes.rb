class CreateNodes < ActiveRecord::Migration[8.0]
  def change
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
  end
end
