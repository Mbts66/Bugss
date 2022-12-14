class SessionsController < ApplicationController
  def new
    redirect_to root_url if current_user.present?
  end


  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    if @user && @user.authenticate(params[:session][:password])
      # Log the user in and redirect to the user's show page.
      log_in @user
      # session[:user_id]=@user.id

      redirect_to @user
    else
      # Create an error message.
      flash.now[:danger] = 'Invalid email/password combination' #Not quite right!
      render 'new'
    end
  end

  def destroy
    log_out
    # session[:user_id]=nil
    redirect_to root_url
  end
end
