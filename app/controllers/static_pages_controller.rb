class StaticPagesController < ApplicationController

	def home
		if logged_in?
			@updates = Update.all
			@users = User.all
			@user = current_user
			@conversations = Conversation.involving(current_user).order("created_at DESC")
			@micropost  = current_user.microposts.build
			@feed_items = current_user.feed
		end
	end
end
