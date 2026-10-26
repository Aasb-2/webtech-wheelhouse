class AddMechanicToUsers < ActiveRecord::Migration[8.1]
  def change
    add_reference :users, :mechanic, null: true, foreign_key: true, index: { unique: true }
  end
end