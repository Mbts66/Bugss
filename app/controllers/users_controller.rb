class UsersController < ApplicationController
  before_action :current_user 
  def home
    # @user = User.all   
    # puts(@user)
  end

  def display
    @user = User.all   
    puts(@user)
  end

  # def login
    
  # end

  def signup
  end

  def show
    # byebug
    @user = User.find(params[:id])
    authorize! :update, @user

  end
  
  def new
    @user = User.new
    @user.save
  end

  def create
    # @user = User.new(params[:user]) # Not the final implementation!
    #updated strong param

    @user = User.create(user_params)
    if @user
      log_in @user
      # session[:user_id]=@user.id

      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end



  private
      def user_params
        params[:user][:role] = params[:user][:role].to_i
        params.require(:user).permit(:id, :name, :email, :role, :is_admin, :password,:password_confirmation)
      end
end
