class CreateQuicks < ActiveRecord::Migration[5.2]
  def change
    create_table :quicks do |t|
      t.integer :user_id
      t.integer :friend_id
      t.integer :shop_id
      t.boolean :request

      t.timestamps
    end
  end
end
