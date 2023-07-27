class CreateRooms < ActiveRecord::Migration[6.1]
  def change
    create_table :rooms do |t|
      t.string :name
      t.text :introduction
      t.integer :price
      t.string :adress
      t.binary :room_image

      t.timestamps
    end
  end
end
