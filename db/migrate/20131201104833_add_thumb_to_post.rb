class AddThumbToPost < ActiveRecord::Migration
  def change
    add_column :posts, :thumb, :string
    add_column :posts, :remove_thumb, :boolean
    add_column :posts, :thumb_cache, :string
  end
end
