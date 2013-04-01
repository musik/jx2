# -*- encoding : utf-8 -*-
class AddIndexToDrugs < ActiveRecord::Migration
  def change
    add_index :drugs,:name
  end
end
