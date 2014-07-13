#coding: utf-8
module BrandsHelper

   def get_brand_name(brand)
     if(brand.nil?)
       "没有输入品牌"
     else
       brand.name;
     end


   end

   def get_brand_name_link(brand)
     if(brand.nil?)
        "没有输入品牌"
     else
        link_to brand.name ,brand_path(brand)
     end
   end

end
