# encoding: utf-8
class StatsController < ApplicationController
  DATE_FORMAT = "%Y%m%d";

  def default

  end

  def amountStats
    time_clause = prepare_where_clause()
    sort_by="quan"
    get_result(time_clause, sort_by)
    render :stats
  end

  def frequencyStats
    time_clause = prepare_where_clause()
    sort_by="freq"
    get_result(time_clause, sort_by)
    render :stats
  end

  def get_result(time_clause, sort_by)
    @results = ActiveRecord::Base.connection.execute(
        "select r.item_id,i.item_code,b.name,sum(r.box) box,sum(r.quantity) quan,count(r.id) freq from records r left join items i on i.id=r.item_id left join brands b on b.id=i.brand_id #{time_clause} group by item_id order by #{sort_by} desc")
    @result_array = []
    i=0
    @results.each do |row|
      @result_array[i]=row
      i+=1
      puts row.inspect
    end
  end


  def prepare_where_clause
    time_clause=nil;
    puts params.to_yaml
    puts params[:type].to_yaml

    if params[:period]=="month"
      time_clause = "  date>= #{Date.today.at_beginning_of_month.to_time.strftime(DATE_FORMAT).to_i} and date<=#{Date.today.at_end_of_month.to_time.strftime(DATE_FORMAT).to_i}"
    elsif params[:period]=="week"
      time_clause = " date>= #{Date.today.at_beginning_of_week.to_time.strftime(DATE_FORMAT).to_i} and date<=#{Date.today.at_end_of_week.to_time.strftime(DATE_FORMAT).to_i}"
    elsif params[:period]=="year"
      time_clause = " date>= #{Date.today.at_beginning_of_year.to_time.strftime(DATE_FORMAT).to_i} and date<=#{Date.today.at_end_of_year.to_time.strftime(DATE_FORMAT).to_i}"
    end
    @buy_sell
    if !time_clause.nil?
      time_clause = "#{time_clause} and ";
    end
    if  !params[:type].nil?

      if params[:type] =="buy"
        time_clause = "#{time_clause} buy_sell=1"
        @buy_sell='进货统计'
      elsif params[:type] == "sell"
        time_clause ="#{time_clause} buy_sell=2"
        @buy_sell='出货统计'
      end
    elsif @buy_sell='出货统计'
      time_clause ="#{time_clause} buy_sell=2"
    end


    if !time_clause.nil?
      time_clause = "where #{time_clause}"
    end
    puts "#{time_clause}"
    time_clause
  end


end
