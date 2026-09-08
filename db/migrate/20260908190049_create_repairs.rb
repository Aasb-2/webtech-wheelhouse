class CreateRepairs < ActiveRecord::Migration[8.1]
  def change
    create_table :repairs do |t|
      t.integer :bike_id, null: false
      t.integer :mechanic_id
      t.string :status, null: false, default: "dropped_off"
      t.string :decision
      t.date :promised_on
      t.datetime :dropped_off_at, null: false
      t.datetime :collected_at

      t.timestamps
    end
  end
end
