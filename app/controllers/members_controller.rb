class MembersController < ApplicationController
  def index
    @members = Member.all
    render json: @members
  end

  def show
    @member = Member.find(params[:id])
    render json: @member
  end

  def new
    @member = Member.new
    render json: "NEW"
  end

  def edit
    @member = Member.find(params[:id])
  end

  def create
    @member = Member.new(member_params)

    if @member.save
      # redirect_to @member
      render json: "New member created #{@member.name}"
    else
      render json: "Error."
    end
  end

  def update
    @member = Member.find(params[:id])

    if @member.update(member_params)
      redirect_to @member
    else
      render 'edit'
    end
  end

  def destroy
    @member = Member.find(params[:id])
    @member.destroy

    redirect_to members_path
  end

  private
    def member_params
      params.require(:member).permit(:email, :name)
    end
end
