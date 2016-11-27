class Notification < ActiveRecord::Base
	belongs_to :user
	belongs_to :notified_by, class_name: 'User'  
	belongs_to :micropost
	validates :user_id, :notified_by_id, :micropost_id, :notice_type, presence: true
end
