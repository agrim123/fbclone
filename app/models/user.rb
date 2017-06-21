class User < ActiveRecord::Base
  acts_as_voter
  has_many :conversations, :foreign_key => :sender_id
  after_create :create_default_conversation
  has_many :comments, dependent: :destroy
  has_many :notifications, dependent: :destroy

  has_many :microposts, dependent: :destroy
  has_many :active_relationships,  class_name:  "Relationship",
  foreign_key: "follower_id",
  dependent:   :destroy
  has_many :passive_relationships, class_name:  "Relationship",
  foreign_key: "followed_id",
  dependent:   :destroy
  has_many :following, through: :active_relationships,  source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  before_save { self.email = email.downcase }
  validates :first_name,  presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
  format: { with: VALID_EMAIL_REGEX },
  uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
  mount_uploader :picture, PictureUploader
  validate  :picture_size

  def self.search(search)
    where("first_name LIKE ?", "%#{search}%")
    where("last_name LIKE ?", "%#{search}%")
  end

  def feed
    following_ids = "SELECT followed_id FROM relationships
    WHERE  follower_id = :user_id"
    Micropost.where("user_id IN (#{following_ids})
     OR user_id = :user_id", user_id: id)
  end

  # Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
    BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Follows a user.
  def follow(other_user)
    active_relationships.create(followed_id: other_user.id)
  end

  # Unfollows a user.
  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  # Returns true if the current user is following the other user.
  def following?(other_user)
    following.include?(other_user)
  end

  def create_default_conversation
    Conversation.create(sender_id: 1, recipient_id: self.id) unless self.id == 1
  end

  private

  # Validates the size of an uploaded picture.
  def picture_size
    if picture.size > 5.megabytes
      errors.add(:picture, "should be less than 5MB")
    end
  end
end
