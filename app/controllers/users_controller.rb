class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy,:following, :followers,:show]    
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy

  def index
    user_array =[]
    @users = User.all
    @conversations = Conversation.involving(current_user).order("created_at DESC")
    if params[:search]
      @users = User.search(params[:search]).order("created_at DESC")
    else
      @users = User.all.order('first_name')
    end
  end
  def show
   @user = User.find(params[:id])
   @followers = @user.followers
   @users= User.all
   @conversations = Conversation.involving(current_user).order("created_at DESC")
   @user = User.find(params[:id])
   @microposts = @user.microposts
   @micropost = Micropost.new
 end

 def new
   @user = User.new
 end

 def create
  @user = User.new(user_params)
  if @user.save
    @user.follow follow_admins  # -------HERE!!

    log_in @user
    redirect_to root_path
  else
    render 'new'
  end
end

def edit
 @conversations = Conversation.involving(current_user).order("created_at DESC")
 @user = User.find(params[:id])
 @users = User.all
end

def update
  @user = User.find(params[:id])
  if @user.update_attributes(user_params)
    flash[:success] = "Profile updated"
    redirect_to @user
  else
    render 'edit'
  end
end

def destroy
  @user = User.find(params[:id]).destroy
  flash[:success] = "User deleted"
  redirect_to users_url
end
def following
  @title = "Following"
  @user = User.find(params[:id])
  @users = @user.following
  render 'show_follow'
end

def followers
  @title = "Followers"
  @user = User.find(params[:id])
  @users = @user.followers
  render 'show_follow'
end
private
def follow_admins
  admins = User.find_by_admin(true)
  #admins.each do |admin|
 #   self.follow!(admin)
 # end
end
def user_params
  params.require(:user).permit(:first_name,:last_name,:mobile, :email, :password,:password_confirmation,:userpicture,:picture)
end

    # Before filters

    # Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end
    # Confirms the correct user.
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
    # Confirms an admin user.
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
  end  