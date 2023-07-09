class AddNameProfileToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :name, :string #name追記
    add_column :users, :profile, :text #prifile追記
  end
end
