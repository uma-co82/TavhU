class ChangeDataShopImageIdToShops < ActiveRecord::Migration[5.2]
  def change

  	change_column :shops, :shop_image_id, :text
  end
end
