class Profile < ApplicationRecord
  enum role: {
    user_profile: 0,
    admin_profile: 1
  }

  validates :name, presence: true, length: { maximum: 100 }
  validates :bio, length: { maximum: 1000 }

  belongs_to :user
end
