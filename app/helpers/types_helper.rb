#coding: utf-8
module TypesHelper
  def get_type_name(type)
    if(type.nil?)
      return "没有输入类型"
    else
      return type.name;
    end
  end

  def get_type_name_link(type)
    if(type.nil?)
      return "没有输入类型"
    else
      return link_to type.name ,type_path(type);
    end
  end
end
