class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  after_create :send_welcome_email

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
  has_many :likes, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :likeable, source_type: 'Post'
  has_many :liked_comments, through: :likes, source: :likeable, source_type: 'Comment'

  private

  def send_welcome_email
    UserMailer.welcome(self).deliver_now
  end
end
