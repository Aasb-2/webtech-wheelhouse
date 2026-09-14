class AddForeignKeysToRepairLineItems < ActiveRecord::Migration[8.1]
  def change
    add_index :repair_line_items, :repair_id
    add_index :repair_line_items, :service_item_id
    add_foreign_key :repair_line_items, :repairs
    add_foreign_key :repair_line_items, :service_items
  end
end