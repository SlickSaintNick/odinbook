class LikedPost < ApplicationRecord
  belongs_to :user_liked_post, class_name: 'Post'
  belongs_to :post_liked_by_user, class_name: 'User'
end
