class ApplicationController < ActionController::Base
    # rescue_from CanCan::AccessDenied do |exception|
    #redirect_to root_url, alert: exception.message
    # end

    before_action :authenticate_user

    include SessionsHelper

    def authenticate_user
      if current_user.present?
        return true
      else
        redirect_to login_path
      end
    end
  end
