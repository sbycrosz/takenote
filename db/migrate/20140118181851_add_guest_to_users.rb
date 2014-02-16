class AddGuestToUsers < ActiveRecord::Migration
  def change
    add_column :users, :guest, :boolean, default: false
    add_index :users, :guest
  end
end
