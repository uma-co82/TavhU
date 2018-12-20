class AddColumnToShopsAddressAll < ActiveRecord::Migration[5.2]
  def change
    add_column :shops, :address_all, :text
  end
end
