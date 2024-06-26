class Post < ApplicationRecord
  enum status: {
    public_post: 0,
    private_post: 1,
    archived_post: 2
  }

  validates :body, presence: true, length: { maximum: 1000 }
  validate :acceptable_image

  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy
  has_many :likers, through: :likes, source: :user

  has_one_attached :post_image

  private

  def acceptable_image
    return unless post_image.attached?

    errors.add(:post_image, 'is too big') unless post_image.blob.byte_size <= 1.megabyte

    acceptable_types = ['image/jpeg', 'image/png']
    return if acceptable_types.include?(post_image.content_type)

    errors.add(:post_image, 'must be a JPEG or PNG')
  end
end
