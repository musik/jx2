# -*- encoding : utf-8 -*-
class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.string :name
      t.string :url
      t.boolean :published,:default=>true
      t.integer :priority,:default=>5
      t.string :context
      t.boolean :inhome,:default=>true

      t.timestamps
    end
  end
end
