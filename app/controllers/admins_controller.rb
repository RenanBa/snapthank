require 'securerandom'
class AdminsController < ApplicationController

  def login
    if logining(params[:admin_name], params[:password])
      session[:admin_id] = SecureRandom.hex(32)
      @members = Member.all
      5.times{p "logged in"}
      render 'show'
    else
      @error = "Email or password incorrect!"
      render "/sessions/new"
    end
  end

  def logout
    session[:admin_id] = nil
    redirect_to root_url
  end

  def index
    10.times{ p "Index"}
  end

  def show
    if session[:admin_id] == nil || session[:admin_id] == ""
      redirect_to root_url
    else
      @members = Member.all
    end
  end

  # def new
  #    10.times{ p "New"}
  #   @admin = Admin.new
  # end

  # def edit
  #   @admin = Admin.find(params[:id])
  # end

  # def create
  #   10.times{ p "Create"}
  #   @admin = Admin.new(admin_name: params[:admin_name], email: params[:email])
  #   @admin.password = params[:password]
  #   if @admin.save
  #     redirect_to @admin
  #   else
  #     render 'new'
  #   end
  # end

  # def update
  #   @admin = Admin.find(params[:id])

  #   if @admin.update(admin_params)
  #     redirect_to @admin
  #   else
  #     render 'edit'
  #   end
  # end

  # def destroy
  #   @admin = Admin.find(params[:id])
  #   @admin.destroy

  #   redirect_to admins_path
  # end

  # private
  #   def admin_params
  #     params.require(:admin).permit(:admin_name, :email, :password_hash)
  #   end
end
