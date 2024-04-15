class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one :profile, dependent: :destroy

  has_many :follows,
           inverse_of: :following_user,
           foreign_key: 'following_user_id',
           class_name: 'Follow',
           dependent: :destroy
  has_many :followed_users, through: :follows

  has_many :followers,
           inverse_of: :followed_user,
           foreign_key: 'followed_user_id',
           class_name: 'Follow',
           dependent: :destroy
  has_many :following_users, through: :followers

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_many :liked_posts, dependent: :destroy, foreign_key: :post_liked_by_user_id, inverse_of: :user_liked_post
  has_many :user_liked_posts, through: :liked_posts

  has_many :liked_comments, dependent: :destroy, foreign_key: :comment_liked_by_user_id, inverse_of: :user_liked_comment
  has_many :user_liked_comments, through: :liked_comments
end
