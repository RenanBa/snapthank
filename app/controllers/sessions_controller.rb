class SessionsController < ApplicationController
  def create
    user = User.from_omniauth(request.env['omniauth.auth'])
    session[:user_id] = user.id
    flash[:success] = "Welcome, #{user.name}"
    @donor = Donor.find(session[:id_donor])
    redirect_to @donor
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "Goodbye!"
    redirect_to root_url
  end
end
