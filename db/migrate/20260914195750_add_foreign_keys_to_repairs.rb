class AddForeignKeysToRepairs < ActiveRecord::Migration[8.1]
  def change
    add_index :repairs, :bike_id
    add_index :repairs, :mechanic_id
    add_foreign_key :repairs, :bikes
    add_foreign_key :repairs, :mechanics
  end
end