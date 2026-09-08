class CreateServiceItems < ActiveRecord::Migration[8.1]
  def change
    create_table :service_items do |t|
      t.string :name, null: false
      t.decimal :current_price, null: false, precision: 10, scale: 2

      t.timestamps
    end

    add_index :service_items, :name, unique: true
  end
end
