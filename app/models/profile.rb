class Profile < ApplicationRecord
  enum role: {
    user_profile: 0,
    admin_profile: 1
  }

  validates :name, presence: true, length: { maximum: 100 }
  validates :bio, length: { maximum: 1000 }
  validate :acceptable_image

  belongs_to :user
  # has_one_attached :profile_image do |attachable|
  #   attachable.variant :thumb, resize: '50x50'
  # end
  has_one_attached :profile_image do |attachable|
    attachable.variant :thumb, resize_and_pad: [200, 200, { crop: :none }]
  end

  private

  def acceptable_image
    return unless profile_image.attached?

    errors.add(:profile_image, 'is too big') unless profile_image.blob.byte_size <= 1.megabyte

    acceptable_types = ['image/jpeg', 'image/png']
    return if acceptable_types.include?(profile_image.content_type)

    errors.add(:profile_image, 'must be a JPEG or PNG')
  end
end
