class AddContactToEntry < ActiveRecord::Migration
  def change
    add_column :entries, :contact, :string
    add_column :entries, :phone, :string
    add_column :entries, :company_name, :string
  end
end
