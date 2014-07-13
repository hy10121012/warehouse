module ItemsHelper

  def get_item_by_rough_search
    name=params[:name];
    Item.rough_search_by_name(name)

  end





end
