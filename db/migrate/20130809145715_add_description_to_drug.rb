class AddDescriptionToDrug < ActiveRecord::Migration
  def change
    add_column :drugs, :description, :string
    File.read("./db/jibings.txt").split("\n").compact.each do |str|
      next if str.blank?
      Jibing.create :name=>str
    end
  end
end
