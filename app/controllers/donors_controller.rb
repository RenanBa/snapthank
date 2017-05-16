class DonorsController < ApplicationController
  # def index
    # if permission()
  #     @donors = Donor.all
  #     render json: @donors
  #   else
  #     render json: "Access not authorized"
  #   end
  # end

  def show
    # if permission()
      @donor = Donor.find(params[:id])
      # render json: @donor
    # else
    #   render json: "Access not authorized"
    # end
  end

  # def new
  #   @donor = Donor.new
  # end

  # def edit
  #   @donor = Donor.find(params[:id])
  # end

  # def create
  #   if request_ip(request.ip)
  #     @donor = Donor.new(email: params[:email], name: params[:name], donation: params[:donation])
  #     if @donor.save
  #       render json: "New donor created #{@donor.name}"
  #     else
  #       render json: "Error."
  #     end
  #   else
  #     render json: "Access not authorized"
  #   end
  # end

  # Create with mailer action call
  def create
    @donor = Donor.new(email: params[:email], name: params[:name], donation: params[:donation])
    @member = Member.find_by(name: "Renan Souza")
    respond_to do |format|
      if @donor.save
        # Tell the donorMailer to send a welcome email after save
        UserMailer.welcome_email(@member, @donor).deliver_later

        format.html { redirect_to(@donor, notice: 'donor was successfully created.') }
        format.json { render json: @donor, status: :created, location: @donor }
      else
        format.html { render action: 'new' }
        format.json { render json: @donor.errors, status: :unprocessable_entity }
      end
    end
  end


  # def update
    # if permission()
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

  # def destroy
    # if permission()
  #     @donor = Donor.find(params[:id])
  #     @donor.destroy
  #     render json: "donor deleted."
  #   else
  #     render json: "Access not authorized"
  #   end
  # end

  # private
  #   def donor_params
  #     params.require(:donor).permit(:email, :name)
  #   end
end
