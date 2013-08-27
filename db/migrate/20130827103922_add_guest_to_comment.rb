class AddGuestToComment < ActiveRecord::Migration
  def change
    add_column :comments, :author_name, :string
    add_column :comments, :author_ip, :string
    add_column :comments, :author_email, :string
    add_column :comments, :approved, :boolean

    add_index :comments, :approved
    add_index :comments, :parent_id
    add_index :comments, :created_at
    add_index :comments, [:approved,:created_at],:name=>:approved_created_at
    remove_index :comments,["commentable_id"]
    add_index :comments,[:commentable_id,:commentable_type],:name=>:commentable
  end
end
