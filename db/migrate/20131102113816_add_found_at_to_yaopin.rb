class AddFoundAtToYaopin < ActiveRecord::Migration
  def change
    add_column :yaopins, :found_at, :timestamp
  end
end
