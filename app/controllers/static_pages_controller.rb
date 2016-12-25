class StaticPagesController < ApplicationController

	def home
		if logged_in?
			@users = User.all
			@user = current_user
			@conversations = Conversation.involving(current_user).order("created_at DESC")
			@micropost  = current_user.microposts.build
			@feed_items = current_user.feed.paginate(page: params[:page], per_page: 6).order(created_at: :desc)
			respond_to do |format|  
				format.html 
				format.js { render 'home' }
			end
		end
	end
end
