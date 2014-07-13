class TypesController < ApplicationController
  def new

  end
  def create
    @type = Type.new
    @type.name=params[:type][:name]
    @type.save
    redirect_to "/main/edit"
  end

  def show
    @type = Type.find(params[:id])
    @records = Record.where("item_id in (select id from items where type_id = #{params[:id]})");
  end

  def destroy
    Type.destroy(params[:id])
    redirect_to "/main/edit"
  end
end
