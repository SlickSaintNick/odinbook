class LikedComment < ApplicationRecord
  belongs_to :user_liked_comment, class_name: 'Comment'
  belongs_to :comment_liked_by_user, class_name: 'User'
end
