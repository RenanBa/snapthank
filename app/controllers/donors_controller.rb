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
    @donor = Donor.find(params[:id])
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

  # def new
  #   @donor = Donor.new
  # end

  # def edit
  #   @donor = Donor.find(params[:id])
  # end

  # Create with mailer action call
  def create

    if request_ip(request.ip)
      @donor = Donor.new(email: params[:email], name: params[:name],
                         donation: params[:donation], key: SecureRandom.hex(32))
      respond_to do |format|
        if @donor.save
          @member = select_member(@donor)
          UserMailer.welcome_email(@member, @donor).deliver_later
          format.html { redirect_to(@donor, notice: 'donor was successfully created.') }
          format.json { render json: @donor, status: :created, location: @donor }
        else
          format.html { render action: 'new' }
          format.json { render json: @donor.errors, status: :unprocessable_entity }
        end
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
