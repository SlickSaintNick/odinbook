class CreateLikedComments < ActiveRecord::Migration[7.1]
  def change
    create_table :liked_comments do |t|
      t.references :user_liked_comment, foreign_key: { to_table: :comments }
      t.references :comment_liked_by_user, foreign_key: { to_table: :users }
      t.timestamps
      t.index [:user_liked_comment_id, :comment_liked_by_user_id], unique: true
    end
  end
end
