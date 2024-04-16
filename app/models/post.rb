class Post < ApplicationRecord
  enum status: {
    public_post: 0,
    private_post: 1,
    archived_post: 2
  }

  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy
  has_many :likers, through: :likes, source: :user
end
