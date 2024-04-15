class Profile < ApplicationRecord
  enum role: {
    user_profile: 0,
    admin_profile: 1
  }
  belongs_to :user
end
