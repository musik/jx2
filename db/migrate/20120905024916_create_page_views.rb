# -*- encoding : utf-8 -*-
class CreatePageViews < ActiveRecord::Migration
  def change
    create_table :page_views do |t|
      t.string :viewable_type
      t.integer :viewable_id
      t.string :user_agent,:ip,:referer,:visitor_hash
      t.integer :user_id
      t.timestamp :created_at
    end
  end
end
