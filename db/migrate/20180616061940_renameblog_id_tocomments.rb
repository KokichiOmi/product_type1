class RenameblogIdTocomments < ActiveRecord::Migration[5.1]
  def change
    rename_column :comments, :blog_id, :post_id
  end
end
