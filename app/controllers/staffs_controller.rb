class StaffsController < ApplicationController

  def validate
    render :text=>Staff.is_valid?(params[:name]), :layout=>false
  end

  def new

  end

  def create
    staff = Staff.new
    staff.name = params[:staffs][:name]
    staff.save
    redirect_to "/main/list"
  end

  def search_name
    @items =   Staff.find_by_name_rough(params[:name]);
    render :json=>@items.select("id,name"), :layout=>false;
  end


end
