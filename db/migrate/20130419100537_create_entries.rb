class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.string :title
      t.references :yaopin
      t.string :chengfen
      t.string :yongfa
      t.string :zhuzhi
      t.string :name
      t.string :guige
      t.string :changjia_name
      t.string :pihao
      t.string :tags_input
      t.text :description

      t.timestamps
    end
    add_index :entries, :yaopin_id
  end
end
