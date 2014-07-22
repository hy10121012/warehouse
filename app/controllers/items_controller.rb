require "buySell";

class ItemsController < ApplicationController

  def new
    @items = Item.all;
    @brands = Brand.all;
    @types = Type.all;

  end
  def create
    puts
    STDOUT.sync = true
    if Item.find_by_item_code(params[:item][:item_code]).nil?
      @item = Item.new
      @item.name=params[:item][:name]
      @item.brand_id=params[:item][:brand_id]
      @item.item_code=params[:item][:item_code]
      @item.type_id=params[:item][:type_id]
      @item.price=params[:item][:price]
      @item.save
      redirect_to "/main/edit"
    else
      redirect_to "/main/edit"
    end
  end
  def show
    STDOUT.sync = true
    @item = Item.find(params[:id])
  end

  def show_by_date
    @record = Record.where("item_id = #{params[:id]} and (date>=#{params[:start_date].gsub('/','')} and date <=#{params[:end_date].gsub('/','')})");
    if @record.size>0
      render :_history_table_item,:locals => {record:@record}, :layout=>false
    else
      render :text=>"nothing", :layout=>false
    end
  end
  def edit
    @brands = Brand.all;
    @types = Type.all;
    @item = Item.find(params[:id])
  end

  def search_by_item_code
    @item=Item.find_by_item_code(params[:code]);
    if(@item.nil?)
      redirect_to  :controller => 'main', :action => 'index',:no_found=>true;
    else
      redirect_to item_path(@item)
    end
  end
  def update
    @item = Item.find(params[:id])
    @item.name = params[:item][:name];
    @item.price = params[:item][:price];
    @item.type_id = Type.find(params[:item][:type_id])
    @item.brand_id = params[:item][:brand_id];
    @item.item_code = params[:item][:item_code]
    @item.save
    redirect_to item_path(@item)
  end

  def destroy
    Item.destroy(params[:id])
    redirect_to "/main/edit"
  end

  def rough_search
    @items =   Item.find_by_code_rough(params[:code]);
    render :json=>@items.select("id,item_code"), :layout=>false;
  end

  def name_search
    @items =   Item.find_by_item_code(params[:code]);
    puts @items.to_yaml
    render :text=>!@items.nil?, :layout=>false;
  end

  def search_price
    @items =   Item.find_by_item_code(params[:code]);
    render  :text=>@items.price, :layout=>false;
  end
end