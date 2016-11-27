class Micropost < ActiveRecord::Base
=begin	  acts_as_taggable # Alias for acts_as_taggable_on :tags
	  acts_as_taggable_on :users
=end
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
	  #before_validation :clean_up_tags

  # Clean up tag formatting
 # def clean_up_tags
 #   # Make lowercase 
 #   self.tag_list.map!(&:downcase) 
#
#    # Replace any non-word ([^\w]) characters with a hyphen
#    self.tag_list.map! {|tag| tag.gsub(/[^\w]+/i,'-')} 
#end

private

    # Validates the size of an uploaded picture.
    def picture_size
    	if picture.size > 5.megabytes
    		errors.add(:picture, "should be less than 5MB")
    	end
    end
end