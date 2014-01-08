class CreateShops < ActiveRecord::Migration
  def change
    create_table :shops ,options: " default CHARSET=utf8" do |t|
      t.string :name
      t.string :website
      t.string :affurl
      t.boolean :linked
      t.string :cert
      t.string :company_name
      t.string :service
      t.string :owner
      t.string :address
      t.string :domain
      t.date :reg_in
      t.date :expires_in

      t.timestamps
    end
    add_index :shops,:domain,:uniq=>true
  end
end
