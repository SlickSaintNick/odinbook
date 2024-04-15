class CreateLikedPosts < ActiveRecord::Migration[7.1]
  def change
    create_table :liked_posts do |t|
      t.references :user_liked_post, foreign_key: { to_table: :posts }
      t.references :post_liked_by_user, foreign_key: { to_table: :users }
      t.timestamps
      t.index [:user_liked_post_id, :post_liked_by_user_id], unique: true
    end
  end
end
