class AddContactToUser < ActiveRecord::Migration
  def change
    add_column :users, :contact, :string
    add_column :users, :phone, :string
  end
end
