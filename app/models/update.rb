class Update < ActiveRecord::Base
	validates :title,:body, presence: true
	  default_scope -> { order(created_at: :desc) }

end
