class Staff < ActiveRecord::Base
  has_many :records

  def self.is_valid?(name)
    !self.find_by_name(name).nil?
  end

  def self.find_by_name_rough(code)
    where "name like '%#{code}%'"
  end


end
