require 'securerandom'
class DonorsController < ApplicationController
  def index
    if request_ip(request.ip)
      @donors = Donor.all
      render json: @donors
    else
      render json: "Access not authorized"
    end
  end

  def show
    @donor = Donor.find_by_id(params[:id])
    if @donor.nil?
      render 'error'
    else
      if session[:donor_key] == nil || session[:donor_key] == ""
        if params[:key] != @donor.key
          render json: "Access not authorized"
        else
          session[:donor_key] = @donor.key
          session[:id_donor] = @donor.id
          @video_upload = Video.new
        end
      elsif session[:donor_key] == @donor.key
        @video_upload = Video.new
      end
    end
  end

  # def new
  #   @donor = Donor.new
  # end

  # def edit
  #   @donor = Donor.find(params[:id])
  # end

  # Create with mailer action call
  def create
    # if request_ip(request.ip)
    if check(params)
      @donor = Donor.new(
                          first_name: params[:first_name],
                          last_name: params[:last_name],
                          email: params[:email],
                          donation: params[:donation],
                          campaign_name: params[:campaign],
                          affiliate: params[:affiliate],
                          secure_id: params[:secure_id],
                          campaign_slug: params[:campaign_slug],
                          key: SecureRandom.hex(32)
                        )
      if @donor.save
        respond_to do |format|
          @member = select_member(@donor)
          UserMailer.welcome_email(@member, @donor).deliver_later(wait: schedule.minutes)
          format.json { render json: @donor, status: :created, location: @donor }
        end
      else
        render json: @donor.errors.full_messages
      end
    else
      render json: "Access not authorized"
    end
  end


  # def update
    # if request_ip(request.ip)
  #     @donor = Donor.find_by(email: params[:find_email])
  #     if @donor.update(email: params[:new_email], name: params[:name])
  #       render json: "donor update name: #{@donor.name}. Email: #{@donor.email}"
  #     else
  #       render json: "Error to update"
  #     end
  #   else
  #     render json: "Access not authorized"
  #   end
  # end

  def destroy
    if request_ip(request.ip)
      @donor = Donor.find(params[:id])
      @donor.destroy
      render json: "donor deleted."
    else
      render json: "Access not authorized"
    end
  end

  # private
  #   def donor_params
  #     params.require(:donor).permit(:email, :name)
  #   end
end
