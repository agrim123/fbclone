class Micropost < ActiveRecord::Base
  acts_as_votable
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :content, presence: true
  mount_uploader :picture, PictureUploader
  validate  :picture_size
  has_many :comments ,dependent: :destroy
  has_many :notifications, dependent: :destroy
  validates :visible, presence:true

  private

  # Validates the size of an uploaded picture.
  def picture_size
    if picture.size > 5.megabytes
      errors.add(:picture, "should be less than 5MB")
    end
  end
end
