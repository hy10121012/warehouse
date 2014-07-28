class CreateInventories < ActiveRecord::Migration
  def change
    create_table :inventories do |t|
      t.integer :item_id
      t.integer :box
      t.integer :quantity
      t.integer :start_date
      t.integer :end_date
      t.integer :is_latest_version
      t.timestamps
    end
  end
end
