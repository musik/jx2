class CreateJiItems < ActiveRecord::Migration
  def change
    create_table :ji_items do |t|
      t.references :jibing
      t.references :drug
      t.integer :position,:default=>1
      t.integer :likes,:default=>0

      t.timestamps
    end
    add_index :ji_items, :jibing_id
    add_index :ji_items, :drug_id
  end
end
