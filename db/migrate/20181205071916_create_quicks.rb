class CreateQuicks < ActiveRecord::Migration[5.2]
  def change
    create_table :quicks do |t|
      t.integer :user_id
      t.integer :friend_id
      t.integer :seat_id
      t.boolean :request, default: false

      t.timestamps
    end
  end
end
