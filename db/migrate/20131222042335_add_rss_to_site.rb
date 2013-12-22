class AddRssToSite < ActiveRecord::Migration
  def change
    add_column :sites, :rss, :text
  end
end
