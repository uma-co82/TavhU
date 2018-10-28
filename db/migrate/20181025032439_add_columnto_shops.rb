class AddColumntoShops < ActiveRecord::Migration[5.2]
  def change
  	add_column :shops, :shop_image_id, :text
  end
end
