class CreatePrivileges < ActiveRecord::Migration[5.2]
  def change
    create_table :privileges do |t|
      t.integer :shop_id
      t.text :content, null: false

      t.timestamps
    end
  end
end
