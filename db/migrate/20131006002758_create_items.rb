class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.string :item_code
      t.integer :type_id
      t.integer :brand_id
      t.belongs_to :types

      t.timestamps
    end
  end
end
