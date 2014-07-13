class BrandsController < ApplicationController
  DATE_FORMAT = "%Y%m%d"

  def new

  end
  def edit
    @brand = Brand.find(params[:id])
  end
  def update
    @brand = Brand.find(params[:id]);
    @brand.name = params[:brand][:name];
    @brand.save
    redirect_to brand_path(@brand)
  end
  def create
    if Brand.find_by_name(params[:brand][:name]).nil?
      @brand = Brand.new
      @brand.name=params[:brand][:name]
      @brand.brand_country=params[:brand][:brand_country]
      @brand.save
      redirect_to "/main/edit"
    end
  end
  def show
    @brand = Brand.find(params[:id]);
    @results = ActiveRecord::Base.connection.execute("select count(distinct(i.type_id)) from brands b left join items i on i.brand_id=b.id")
    @records = Record.where("item_id in (select id from items where brand_id = #{params[:id]})");
    puts @records.to_yaml
    unless @results.nil?
      @type_size = @results.first[0];
    else
      @type_size=0
    end
    connection = ActiveRecord::Base.connection;
    s_date_arr = connection.execute("select date from records r where item_id in (select id from items where brand_id=#{params[:id]}) order by date asc limit 0,1")
    e_date_arr = connection.execute("select date from records r where item_id in (select id from items where brand_id=#{params[:id]}) order by date desc limit 0,1")
    puts s_date_arr.to_yaml
    unless s_date_arr.first.nil?
      s_date = s_date_arr.first[0];
      e_date = e_date_arr.first[0];
    else
      @type_size=0
    end
    unless s_date.nil?
      month_start = Date.new(s_date.to_s[0..3].to_i,s_date.to_s[4..5].to_i,1)
      month_end =  Date.new(e_date.to_s[0..3].to_i,e_date.to_s[4..5].to_i,-1)
      @sum = connection.execute("select sum(price*quantity) from records r where item_id in (select id from items where brand_id=#{params[:id]}) and (date>=#{month_start.strftime(DATE_FORMAT)} and date<=#{month_end.strftime(DATE_FORMAT)} )").first

    end


  end


  def destroy
    Brand.destroy(params[:id])
    redirect_to "/main/edit"
  end

end
