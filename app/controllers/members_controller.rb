class MembersController < ApplicationController
  def index
    if request_ip(request.ip) || current_admin
      @members = Member.all
      render json: @members
    else
      render json: "Access not authorized"
    end
  end

  def show
    if request_ip(request.ip) || current_admin
      @member = Member.find(params[:id])
      render json: @member
    else
      render json: "Access not authorized"
    end
  end

  # def new
  #   @member = Member.new
  # end

  # def edit
  #   @member = Member.find(params[:id])
  # end

  def create
    10.times{p "member create" }
    if request_ip(request.ip) || current_admin
      @member = Member.new(email: params[:email], name: params[:name])
      if @member.save
        respond_to do |format|
          format.html { redirect_to '/admins/show' }
          format.json { render json: @member, status: :created, location: @member }
        end
      else
        render json: @member.errors.full_messages
      end
    else
      render json: "Access not authorized"
    end
  end

  def update
    if request_ip(request.ip) || current_admin
      @member = Member.find_by(id: params[:id])
      if @member.update(name: params[:member][:name], email: params[:member][:email])
        respond_to do |format|
          format.html { redirect_to '/admins/show' }
          format.json { render json: "Member update name: #{@member.name}. Email: #{@member.email}" }
        end
      else
        render json: @member.errors
      end
    else
      render json: "Access not authorized"
    end
  end

  def edit
    if request_ip(request.ip) || current_admin
      @member = Member.find(params[:id])
    else
      render json: "Access not authorized"
    end
  end

  def destroy
    if request_ip(request.ip) || current_admin
      @member = Member.find(params[:id])
      @member.destroy
      respond_to do |format|
        format.html { redirect_to '/admins/show' }
        format.json { render json: "Member deleted." }
      end
    else
      render json: "Access not authorized"
    end
  end

  # private
  #   def member_params
  #     params.require(:member).permit(:email, :name)
  #   end
end
