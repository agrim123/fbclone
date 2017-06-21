class NotificationsController < ApplicationController
	def link_through
		@notification = Notification.find(params[:id])
		@notification.update read: true
		redirect_to micropost_path @notification.micropost
		@users = User.all
	end
	def index
		@conversations = Conversation.involving(current_user).order("created_at DESC")
		@notifications = current_user.notifications
		@users = User.all
	end
end
