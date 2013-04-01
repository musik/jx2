# -*- encoding : utf-8 -*-
class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
      t.integer :parent_id,:lft,:rgt,:depth
      t.integer :drugs_count,:default=>0

      # t.timestamps
    end
    add_column :drugs,:category_id,:integer
  end
end
