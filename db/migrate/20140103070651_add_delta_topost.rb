class AddDeltaTopost < ActiveRecord::Migration
  def change
    add_column :posts,:delta,:boolean,default: true, null: false
  end
end
