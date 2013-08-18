class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :title
      t.string :url
      t.decimal :price, :precision=>6,:scale=>2
      t.references :yaopin
      t.string :scope

      t.timestamps
    end
    add_index :items, :yaopin_id
  end
end
