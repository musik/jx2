class AddRankToShop < ActiveRecord::Migration
  def change
    add_column :shops, :pr, :integer,limit: 1
    add_column :shops, :br, :integer,limit: 1
    add_column :shops, :alexa, :integer
    add_column :shops, :priority, :integer,limit: 1
  end
end
