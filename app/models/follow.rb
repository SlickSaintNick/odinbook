class Follow < ApplicationRecord
  enum status: {
    pending_follow: 0,
    accepted_follow: 1
  }
  belongs_to :followed_user, class_name: 'User'
  belongs_to :following_user, class_name: 'User'
end
