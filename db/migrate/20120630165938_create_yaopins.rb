# -*- encoding : utf-8 -*-
class CreateYaopins < ActiveRecord::Migration
  def change
    create_table :yaopins do |t|
      t.string :name
      t.string :en
      t.string :wenhao
      t.string :yuanwenhao
      t.string :benweima
      t.string :benweima_beizhu
      t.string :shangpin_name
      t.string :changjia_name
      t.string :changjia_guojia
      t.string :changjia_dizhi
      t.string :guige
      t.string :jixing
      t.string :leibie
      t.date :pizhunri
      t.date :daoqiri
      t.text :meta

      t.timestamps
    end
  end
end
