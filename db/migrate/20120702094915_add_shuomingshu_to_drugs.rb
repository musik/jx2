# -*- encoding : utf-8 -*-
class AddShuomingshuToDrugs < ActiveRecord::Migration
  def change
    add_column :drugs, :shuoming, :text
    add_column :drugs, :has_shuoming, :boolean
    add_column :drugs, :meta, :text
    
    add_index :yaopins,:wenhao
  end
end
