class CreateRecords < ActiveRecord::Migration
  def change
    create_table :records do |t|
      t.integer :item_id
      t.float :price
      t.integer :box
      t.integer :date
      t.integer :quantity
      t.integer :buy_sell
      t.timestamps
    end
  end
end
