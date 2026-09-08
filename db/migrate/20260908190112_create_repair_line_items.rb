class CreateRepairLineItems < ActiveRecord::Migration[8.1]
  def change
    create_table :repair_line_items do |t|
      t.integer :repair_id, null: false
      t.integer :service_item_id, null: false
      t.decimal :price_charged, null: false, precision: 10, scale: 2

      t.timestamps
    end
  end
end
