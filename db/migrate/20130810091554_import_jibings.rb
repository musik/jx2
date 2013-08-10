class ImportJibings < ActiveRecord::Migration
  def change
    if Jibing.count.zero?
      File.read("./db/jibings.txt").split("\n").compact.each do |str|
        next if str.blank?
        Jibing.create :name=>str
      end
    end
  end
end
