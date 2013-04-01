# -*- encoding : utf-8 -*-
class CreateDrugs < ActiveRecord::Migration
  def change
    create_table :drugs do |t|
      t.string :name
      t.string :en,:abbr,:abbr2,:yaopins_count
      

      t.timestamps
    end
    add_column :yaopins,:drug_id,:integer
  end
end
