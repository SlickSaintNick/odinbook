class Comment < ApplicationRecord
  enum status: {
    public_comment: 0,
    private_comment: 1,
    archived_comment: 2
  }

  validates :body, presence: true, length: { maximum: 1000 }

  belongs_to :user
  belongs_to :post

  has_many :comment_replies,
           inverse_of: :comment_reply,
           class_name: 'Comment',
           foreign_key: 'comment_reply_id',
           dependent: :destroy
  belongs_to :comment_reply, class_name: 'Comment', optional: true

  has_many :likes, as: :likeable, dependent: :destroy
  has_many :likers, through: :likes, source: :user
end
