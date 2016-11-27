class UpdatesController < ApplicationController
	before_action :admin_user, only: [:create,:destroy]
	def index
		@conversations = Conversation.involving(current_user).order("created_at DESC")
		@users = User.all
		@updates = Update.all
	end
	def create
		@update = Update.create(updates_params)
		@users = User.all
		@conversations = Conversation.involving(current_user).order("created_at DESC")
		if @update.save
			redirect_to root_url
		else
			render 'new'
		end
	end
	def new
		@conversations = Conversation.involving(current_user).order("created_at DESC")
		@update = Update.new
		@users = User.all
		
	end
	def destroy
		@update.destroy
		redirect_to request.referrer || root_url
	end
	def show
		@updates = Update.all
		@users = User.all
		
		@conversations = Conversation.involving(current_user).order("created_at DESC")
		@update = Update.find(params[:id]) 
	end
	private
	def updates_params
		params.require(:update).permit(:body,:title,:category)
	end
	def admin_user
		redirect_to(root_url) unless current_user.admin?
	end
end
