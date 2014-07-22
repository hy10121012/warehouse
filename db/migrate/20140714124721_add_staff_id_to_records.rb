class AddStaffIdToRecords < ActiveRecord::Migration
  def change
    add_column :records, :staff_id, :integer
  end

  def down
    remove_column :records, :staff_id
  end
end
