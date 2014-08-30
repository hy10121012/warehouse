class AddAttrToOrder < ActiveRecord::Migration
  def up
    add_column :orders, :vat, :integer
    add_column :orders, :discount, :float
  end

  def down
    remove_column :orders, :vat
    remove_column :orders, :discount
  end
end
