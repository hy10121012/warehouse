class CreateBrands < ActiveRecord::Migration
  def change
    create_table :brands do |t|
      t.string :name
      t.string :brand_country

      t.timestamps
    end
  end
end
