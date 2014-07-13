#coding: utf-8
class MainController < ApplicationController

  def index
    @items  = Item.all
    if params[:no_found]
      @no_found = "找不到此货号"
    end
    puts   "---------->#{@no_found}";


  end
  def edit
    @brands = Brand.all
    @types = Type.all
  end

  private
  def get_all_inventry

  end





end
