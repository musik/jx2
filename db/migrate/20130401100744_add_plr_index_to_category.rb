class AddPlrIndexToCategory < ActiveRecord::Migration
  def change
    add_index "categories", ["parent_id","lft"], :name => "index_plr"
  end
end
