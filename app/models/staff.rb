class Staff < ActiveRecord::Base
  has_many :records

  def is_valid?(name)
    !self.find_by_name(name).nil?
  end


end
