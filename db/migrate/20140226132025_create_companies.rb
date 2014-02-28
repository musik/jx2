class CreateCompanies < ActiveRecord::Migration
  def up
    drop_table :companies if table_exists? :companies
    drop_table :stores if table_exists? :stores
    create_table :companies,options: "auto_increment= 1000" do |t|
      t.string :name
      t.string :short
      t.references :city
      t.references :province
      t.string :address
      t.integer :yaopins_count

      t.timestamps
    end
    add_index :companies, :city_id
    add_index :companies, :province_id

    add_column :yaopins,:company_id,:integer
    add_index :yaopins,:company_id
  end
  def down
    drop_table :companies if table_exists? :companies
    remove_column :yaopins,:company_id
  end
end
