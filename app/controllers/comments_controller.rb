class CommentsController < ApplicationController
	before_action :set_micropost
	def index
		@comments = @micropost.comments.to_json
		respond_to do |format|
			format.json {render json: @comments, status: 200 }
		end
	end
	def create  
		@comment = @micropost.comments.build(comment_params)
		@comment.user_id = current_user.id
		if @comment.save
			create_notification @micropost, @comment
			respond_to do |format|  
				format.html { redirect_to root_path }
				format.js
			end  
			#flash[:success] = "You commented the hell out of that micropost!"
			#redirect_to :back
		else
			flash[:alert] = "Check the comment form, something went horribly wrong."
			render root_path
		end
	end
	def destroy  
		@comment = @micropost.comments.find(params[:id])
		if @comment.user_id == current_user.id

			@comment.destroy
			respond_to do |format|
				format.html { redirect_to :back }
				format.js
			end
		end
	end 
	private

	def comment_params  
		params.require(:comment).permit(:content)
	end

	def set_micropost  
		@micropost = Micropost.find(params[:micropost_id])
	end  
	def create_notification(post,comment)  
		return if post.user.id == current_user.id 
		Notification.create(user_id: post.user.id,
			notified_by_id: current_user.id,
			micropost_id: post.id,
			identifier: comment.id,
			notice_type: 'comment')
	end  

end
