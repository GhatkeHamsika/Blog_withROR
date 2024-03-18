class AddLikesAndDislikesToBlogPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :blog_posts, :likes, :integer
    add_column :blog_posts, :dislikes, :integer
  end
end
