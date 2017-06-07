class AdminsController < ApplicationController

  def login
    @admin = Admin.find_by_email(params[:email])
    if @admin.password == params[:password]
      session[:admin_id] = admin.id
    else
      redirect_to home_url
    end
  end

  def index
    10.times{ p "Index"}
    @admins = Admin.all
  end

  def show
    @admin = Admin.find(params[:id])
  end

  def new
     10.times{ p "New"}
    @admin = Admin.new
  end

  def edit
    @admin = Admin.find(params[:id])
  end

  def create
    10.times{ p "Create"}
    @admin = Admin.new(admin_name: params[:admin_name], email: params[:email])
    @admin.password = params[:password]
    if @admin.save
      redirect_to @admin
    else
      render 'new'
    end
  end

  def update
    @admin = Admin.find(params[:id])

    if @admin.update(admin_params)
      redirect_to @admin
    else
      render 'edit'
    end
  end

  def destroy
    @admin = Admin.find(params[:id])
    @admin.destroy

    redirect_to admins_path
  end

  # private
  #   def admin_params
  #     params.require(:admin).permit(:admin_name, :email, :password_hash)
  #   end
end
