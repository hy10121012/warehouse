class AddOrderIdToRecords < ActiveRecord::Migration
  def up
    add_column :records, :order_id, :integer
  end

  def down
    remove_column :records, :order_id
  end
end
