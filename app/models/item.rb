class Item < ActiveRecord::Base
  belongs_to :brand;
  has_many :inventories;
  belongs_to :type;
  has_many :record;
  has_one :primary_inventory, -> { where is_latest_version: 1 }, class_name: "Inventory"

  def self.find_by_code_rough(code)
     where "item_code like '%#{code}%'"
  end


end
