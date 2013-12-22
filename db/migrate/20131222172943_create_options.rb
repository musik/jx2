# encoding : utf-8
class CreateOptions < ActiveRecord::Migration
  def change
    create_table :options,options: " default CHARSET=utf8 " do |t|
      t.string :name
      t.text :data
      t.boolean :autoload
    end
  end
end
