class AddcolumnsToshops < ActiveRecord::Migration[5.2]
  def change
    add_column :shops, :postcode, :integer
    add_column :shops, :prefecture_code, :integer
    add_column :shops, :address_street, :string
    add_column :shops, :address_building, :string
  end
end
