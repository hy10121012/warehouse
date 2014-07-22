# encoding: utf-8
class StatsController < ApplicationController
  DATE_FORMAT = "%Y%m%d";


  def default

  end

  def amountStats
    if good_custom_or_other?
      time_clause,@from,@to  = prepare_where_clause()
      sort_by="quan"
      get_result(time_clause, sort_by)
    end
    render :stats
  end

  def frequencyStats
    if good_custom_or_other?
      time_clause,@from,@to = prepare_where_clause()
      sort_by="freq"
      get_result(time_clause, sort_by)
    end
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
      from =  Date.today.to_time.advance(:months => -1).strftime(DATE_FORMAT).to_i
      to =  Date.today.to_time.strftime(DATE_FORMAT).to_i
      time_clause = "  date>= #{from} and date<=#{to}"
    elsif params[:period]=="week"
      from = Date.today.to_time.advance(:weeks => -1).strftime(DATE_FORMAT).to_i
      to = Date.today.to_time.strftime(DATE_FORMAT).to_i
      time_clause = " date>= #{from} and date<=#{to}"
    elsif params[:period]=="year"
      from = Date.today.to_time.advance(:years => -1).strftime(DATE_FORMAT).to_i
      to = Date.today.to_time.strftime(DATE_FORMAT).to_i
      time_clause = " date>= #{from} and date<=#{to}"
    elsif params[:period]=="custom"
      from =params[:from]
      to =params[:to]
      time_clause = " date>= #{from} and date<=#{to}"
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
    return time_clause,from,to
  end

  def speedy_stats()
    @results = Record.get_speedy_stats_array
    @result_array = []
    @results.each_with_index do |row, i|
      @result_array[i]=row
      puts "---->"+row.inspect
    end
    render :speedy_stats
  end

  def daily(date=Time.now.strftime(DATE_FORMAT).to_i)
    @result_array= Record.get_daily_stats(date)
    item_detail= Record.where("date=#{date} and buy_sell=2")
    @item_count = Hash.new(0);
    item_detail.each do |record|
      @item_count[record.item.item_code]+=record.quantity
    end


    @total_quant=0
    @total_amount=0;
    @result_array.each do |row|
      puts "---->"+row.to_yaml
      @total_quant+=row.total_quant
      @total_amount+=row.amount
    end
    render :daily_stats
  end

  def order_view
    result = Record.where("order_id=#{params[:order_id]}")
    @order_items = result
    puts @order_items.inspect
  end

  def good_custom_or_other?
    (params[:period]=='custom' && !params[:from].nil? && !params[:to].nil? && !params[:from].empty? && !params[:to].empty?) ||  params[:period]!='custom'
  end
end
