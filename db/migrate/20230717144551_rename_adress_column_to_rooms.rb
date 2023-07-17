class RenameAdressColumnToRooms < ActiveRecord::Migration[6.1]
  def change
    rename_column :rooms, :adress, :address
  end
end
