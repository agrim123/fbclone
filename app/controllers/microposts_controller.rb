class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy
  
  def create
    @conversations = Conversation.involving(current_user).order("created_at DESC")
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      if @micropost.onwall == current_user.id 
        create_notification @micropost
      else
        create_notification_otherwall @micropost
      end
      #respond_to do |format|
       # format.js 
      #end
      #flash[:success] = "Micropost created!"
      redirect_to current_user
    else
      @feed_items = []
      redirect_to root_url
    end
  end
  def edit
    @conversations = Conversation.involving(current_user).order("created_at DESC")
    @users = User.all
    @micropost = Micropost.find(params[:id])
  end

  def update
    @conversations = Conversation.involving(current_user).order("created_at DESC")
    @users = User.all
    @micropost = Micropost.find(params[:id])
    if @micropost.update_attributes(micropost_params)
      flash[:success] = "microPost updated."
      redirect_to root_path
    else
      flash[:alert] = "Update failed.  Please check the form."
      render :edit
    end
  end

  def like
    @micropost = Micropost.find(params[:id])
    @micropost.liked_by current_user
    if request.xhr?
      render json: { count: @micropost.get_likes.size, id: params[:id] }
    else
      redirect_to @micropost
    end
  end

  def dislike
    @micropost = Micropost.find(params[:id])
    @micropost.disliked_by current_user
    if request.xhr?
      render json: { count: @micropost.get_likes.size, id: params[:id] }
    else
      redirect_to @micropost
    end
  end
  def show
    @conversations = Conversation.involving(current_user).order("created_at DESC")
    @users = User.all
    @micropost = Micropost.find(params[:id])
  end
  def destroy
    @micropost.destroy
    #flash[:success] = "Micropost deleted"
    redirect_to request.referrer || root_url
  end

  private

  def micropost_params
    params.require(:micropost).permit(:content, :picture,:location,:onwall,:visible,:tag_list,:tags)
  end

  def correct_user
    @micropost = current_user.microposts.find_by(id: params[:id])
    redirect_to root_url if @micropost.nil?
  end 
  def create_notification(post)  
    return if post.id == current_user.id 
    followers = current_user.followers.ids
    followers.each do |follower|
      Notification.create(user_id: follower,
        notified_by_id: current_user.id,
        micropost_id: post.id,
        identifier: nil,
        notice_type: 'updated his status')
    end
  end 
  def create_notification_otherwall(post)  
    return if post.id == current_user.id 
    followers = current_user.followers.ids
    followers.each do |follower|
      Notification.create(user_id: follower,
        notified_by_id: current_user.id,
        micropost_id: post.id,
        identifier: nil,
        notice_type: 'posted on your wall')
    end
  end  
end