class AddCustomerForeignKeyToBikes < ActiveRecord::Migration[8.1]
  def change
    add_index :bikes, :customer_id
    add_foreign_key :bikes, :customers
  end
end