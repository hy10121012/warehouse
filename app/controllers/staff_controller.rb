class StaffController < ApplicationController

  def validate
    render :text=>Staff.is_valid?, :layout=>false
  end
end
