class AddPrivilegeToSeats < ActiveRecord::Migration[5.2]
  def change
    add_column :seats, :privilege_id, :integer
    add_column :seats, :privilege_secound_id, :integer
    add_column :seats, :privilege_third_id, :integer
  end
end
