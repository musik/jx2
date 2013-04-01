class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.text :content
      t.boolean :publish
      t.string :laiyuan
      t.string :laiyuan_url
      t.string :author

      t.timestamps
    end
    add_index :posts,:publish
  end
end
