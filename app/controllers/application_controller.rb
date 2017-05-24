class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  skip_before_filter :verify_authenticity_token, :only => [:create, :update, :destroy]
  include ApplicationHelper
  include MembersHelper


  # Google user info
  private
    def current_user
      @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end

    helper_method :current_user
end
