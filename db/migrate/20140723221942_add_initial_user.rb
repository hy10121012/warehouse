class AddInitialUser < ActiveRecord::Migration
  def up
    User.create(:name=>'root',:password=>'admin123',:email=>'admin@warhouse.com',:auth_level=>1)
    User.create(:name=>'operate',:password=>'operate123',:email=>'operate@warhouse.com',:auth_level=>2)
  end

  def down
    User.delete_all
  end
end
