class Record < ActiveRecord::Base
  belongs_to :item
  belongs_to :staff
  belongs_to :order


  SPEEDY_STATS = "select i.id,i.item_code, sum(r.quantity) sell,count(r.quantity),(select sum(quantity) from records where item_id = res.item and date = res.start_date and buy_sell=1) buy
              from records r,(SELECT item_id item,min(date) start_date,CAST(DATE_ADD(date(date),INTERVAL 1 MONTH) as UNSIGNED) end_date FROM `records` where buy_sell = 1 group by item_id ) res,items i
              where res.item = r.item_id and r.date>=res.start_date and r.date<=res.end_date and buy_sell=2 and i.id = r.item_id
              group by r.item_id having sum(r.quantity)*2 >buy"

  def self.get_speedy_stats_array
    ActiveRecord::Base.connection.execute(SPEEDY_STATS)
  end

  def self.get_daily_stats(data)
    self.select("orders.id order_id,orders.order_number,count(records.item_id) item_quant, sum(records.quantity) total_quant, sum(records.quantity*records.price) amount").where("records.date=#{data} and records.buy_sell=2").joins("left join orders on records.order_id=orders.id").group("records.order_id")
  end


end
