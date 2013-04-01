# -*- encoding : utf-8 -*-
class ChangeCountOnDrugs < ActiveRecord::Migration
  def up
    change_column :drugs,:yaopins_count,:integer
  end

  def down
  end
end
