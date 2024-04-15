class Post < ApplicationRecord
  enum status: {
    public_post: 0,
    private_post: 1,
    archived_post: 2
  }

  belongs_to :user
  has_many :comments, dependent: :destroy

  has_many :liked_posts, dependent: :destroy, foreign_key: :user_liked_post_id, inverse_of: :post_liked_by_user
  has_many :post_liked_by_users, through: :liked_posts
end
