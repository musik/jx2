class CreateJibins < ActiveRecord::Migration
  def change
    create_table :jibings,:options=>'auto_increment = 1000' do |t|
      t.string :name,:null=>false
      t.integer :items_count,:default=>0
      t.timestamps
    end
    File.read("./db/jibings.txt").split("\n").compact.each do |str|
      next if str.blank?
      Jibing.create :name=>str
    end
  end
end
