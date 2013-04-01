class AddExcerptToPost < ActiveRecord::Migration
  def change
    add_column :posts, :excerpt, :string
    add_column :posts, :keywords, :string
    add_column :posts, :seo_title, :string
  end
end
