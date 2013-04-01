# -*- encoding : utf-8 -*-
class AddIndexesOnDrug < ActiveRecord::Migration
  def change
    add_index :drugs,:category_id,:name=>:index_drug_category
    add_index :drugs,:yaopins_count,:name=>:index_yaopins_count
    
    add_index :categories,[:lft,:rgt],:name=>:index_lr
    add_index :categories,:parent_id,:name=>:index_parent
    
    add_index :yaopins, :drug_id, :name => :index_drug_id
    # add_index :yaopins, :name, :name => :index_name
  end
end
