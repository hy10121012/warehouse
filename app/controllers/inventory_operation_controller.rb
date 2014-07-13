require "buySell"
class InventoryOperationController < ApplicationController

  def default

  end
  def   purchase
    @items = Item.all
  end

  DATE_FORMAT = "%Y%m%d"
  DATETIME_FORMAT = "%Y%m%d%H%M";

  def   purchase_action
    STDOUT.sync = true
    qua = params[:purchase][:quantity];
    box = params[:item][:box];
    item = Item.find_by_item_code(params[:code])
    if(!item.nil?)
      purchase_process(box, item.id, qua)
    end
    redirect_to "/main/list"
  end

  def purchase_process(box, item_id, qua)
    puts params.to_yaml
    inventory_records = Inventory.where("item_id = #{item_id} and is_latest_version=1")
    if inventory_records.size==1
      current_inventory = inventory_records[0]
      remaining = current_inventory.quantity.to_i+qua.to_i
      box_remaining = current_inventory.box.to_i+box.to_i
      new_inventory = create_new_inventory(item_id, box_remaining, remaining)

      current_inventory.end_date = Time.now.strftime(DATETIME_FORMAT).to_i
      current_inventory.is_latest_version=0;
      current_inventory.save
    elsif  inventory_records.size==0
      remaining = qua.to_i
      box_remaining = box.to_i
      new_inventory = create_new_inventory(item_id, box_remaining, remaining)
    else
    end
    unless  new_inventory.nil?
      record = create_record(box, qua, BuySell::BUY, item_id)

      new_inventory.transaction do
        unless current_inventory.nil?
          current_inventory.save
        end
        new_inventory.save;
        record.save
      end
    end
  end


  def   sale
    @items = Item.all
  end

  def   sale_action
    STDOUT.sync = true
    qua = params[:sale][:quantity];
    box = params[:item][:box];
    item = Item.find_by_item_code(params[:code])
    sale_process(box, item.id, qua)
    redirect_to "/main/list"
  end

  def sale_process(box, item_id, qua)
    inventory_records = Inventory.where("item_id = #{item_id} and is_latest_version=1")
    if inventory_records.size==1
      current_inventory = inventory_records[0]

      remaining = current_inventory.quantity.to_i-qua.to_i
      box_remaining = current_inventory.box.to_i-box.to_i
      if remaining>=0
        new_inventory = create_new_inventory(item_id, box_remaining, remaining)
        current_inventory.end_date = Time.now.strftime(DATETIME_FORMAT).to_i
        current_inventory.is_latest_version=0;
        unless  new_inventory.nil?
          record = create_record(box, qua, BuySell::SELL, item_id)
          new_inventory.transaction do
            current_inventory.save
            new_inventory.save;
            record.save
          end
        end
      end
    end
  end

  def create_new_inventory(item_id,box_remaining, remaining)
    new_inventory = Inventory.new;
    new_inventory.item_id = item_id;
    new_inventory.box = box_remaining;
    new_inventory.quantity = remaining;
    new_inventory.is_latest_version=1;
    new_inventory.start_date = Time.now.strftime(DATETIME_FORMAT).to_i
    new_inventory
  end




  def create_record(box,qua,buy_sell,item_id)
    record = Record.new
    record.item_id =item_id
    record.price = Item.find(item_id).price
    record.quantity = qua
    record.box = box
    record.buy_sell = buy_sell
    record.date = Time.now.strftime(DATE_FORMAT)
    record
  end
end