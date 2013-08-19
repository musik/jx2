class AddItemCountToDrug < ActiveRecord::Migration
  def change
    add_column :drugs, :items_count, :integer,:default=>0
    Drug.update_all_items_count
  end
end
