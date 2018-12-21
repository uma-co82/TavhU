class CreateShops < ActiveRecord::Migration[5.2]
  def change
    create_table :shops do |t|
      t.text :shop_name, null: false
      t.text :shop_info, null: false
      t.text :shop_image_id
      t.integer :author_id
      t.integer :genre_id, null: false
      t.integer :station_id
      t.integer :postcode, null: false
      t.integer :prefecture_code, null: false
      t.string :address_city, null: false
      t.string :address_street, null: false
      t.string :address_building
      t.string :address
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
