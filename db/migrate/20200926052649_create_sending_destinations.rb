class CreateSendingDestinations < ActiveRecord::Migration[6.0]
  def change
    create_table :sending_destinations do |t|
      t.string :destination_first_name, null: false
      t.string :destination_last_name, null: false
      t.string :destination_first_name_kana, null: false
      t.string :destination_last_name_kana, null: false
      t.string :post_code, null: false
      t.integer :prefecture, null: false
      t.string :city, null: false
      t.string :house_number, null: false
      t.string :building_name
      t.string :phone_number
      t.index :phone_number, unique: true
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
