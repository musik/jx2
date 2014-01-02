class AddPtypeToPost < ActiveRecord::Migration
  def change
    add_column :posts, :post_type_cd, :integer, default: 0
  end
end
