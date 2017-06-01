class MembersController < ApplicationController
  def index
    render json: request.ip
    # if request_ip(request.ip)
    #   @members = Member.all
    #   render json: @members
    # else
    #   render json: "Access not authorized"
    # end
  end

  def show
    if request_ip(request.ip)
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
    if request_ip(request.ip)
      @member = Member.new(email: params[:email], name: params[:name])
      if @member.save
        render json: "New member created #{@member.name}"
      else
        render json: "Error."
      end
    else
      render json: "Access not authorized"
    end
  end

  def update
    if request_ip(request.ip)
      @member = Member.find_by(email: params[:find_email])
      if @member.update(email: params[:new_email], name: params[:name])
        render json: "Member update name: #{@member.name}. Email: #{@member.email}"
      else
        render json: "Error to update"
      end
    else
      render json: "Access not authorized"
    end
  end

  def destroy
    if request_ip(request.ip)
      @member = Member.find(params[:id])
      @member.destroy
      render json: "Member deleted."
    else
      render json: "Access not authorized"
    end
  end

  # private
  #   def member_params
  #     params.require(:member).permit(:email, :name)
  #   end
end
