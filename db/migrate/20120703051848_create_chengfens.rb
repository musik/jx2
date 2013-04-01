# -*- encoding : utf-8 -*-
class CreateChengfens < ActiveRecord::Migration
  def change
    create_table :chengfens do |t|
      t.string :name
      t.text :meta
    end
    create_table :chengfens_drugs,:id=>false do |t|
      t.integer :chengfen_id,:drug_id
    end
    add_index :chengfens,:name
    add_index :chengfens_drugs,[:chengfen_id,:drug_id],:uniq=>true
  end
end
