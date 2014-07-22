class AddOrderIdToRecords < ActiveRecord::Migration
  def change
    add_column :records, :order_id, :integer
  end

  def down
    remove_column :records, :order_id
  end
end
