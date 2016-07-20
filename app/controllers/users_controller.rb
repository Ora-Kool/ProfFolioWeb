class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy] #applying privelege to edit and update
  before_action :correct_user, only: [:edit, :update] #if you are logged_in and tried to edit someone's profile
  before_action :admin_user, only: :destroy
  #show specific user depending on the id
  def index
    @users = User.paginate(page: params[:page])
  end
	def show
		@user = User.find(params[:id])
	end
  #init' a new user
  def new
  	@user = User.new
  end

#Registering a new user when he signup and he/she will automatically get log in
  def create
  	@user = User.new(user_params) 
  	if @user.save
  		 log_in  @user
      flash[:success] = "Prof-Folio welcomes you onboard!"
      redirect_back_or
     #redirect_to @user
  	else
  		render 'new'
  	end
  end

  #when a user wants to edit his/her profile, this method is called
  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      #handle user updated fields
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  #before filters
  #comfirms a logged in user for security
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to login_url #ask user to login if visitor tries to access secured pages from url
    end
  end

  #Comfirms the correct user
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user) #redirecting user back to home if they are not login
  end

   #delete a specific user from the list, this ability is meant only for admins not users
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end


  #all other methods should be above the private identifier
  private
  #form validation, prevent mass assignment vulnerability
  def user_params 
  	params.require(:user).permit(:name, :email, :password, :password_confirmation)# preventing CSTR
  end

  #redirects to stored location (or to the default).
  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  #Stores the url  trying to be accessed.
  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end

 
  #Confirms an admin  user.
  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
end
