class VideosController < ApplicationController

  def index
    @videos = Video.order('created_at DESC')
  end

  def new
    @video = Video.new
  end

  def create
  end

  # This is part of the action mailer for when a new video is created
  # def create
  #   if request_ip(request.ip)
  #     @donor = Donor.find(params[:donor_id])
  #     @video = @donor.videos.create(video_params)
  #     respond_to do |format|
  #       if @video.save
  #         # Request the userMailer to send a welcome email after save
  #         UserMailer.thanks_email(@donor, @video).deliver_later

  #         format.html { redirect_to(@donor, notice: 'video link was successfully created.') }
  #         format.json { render json: @video, status: :created, location: @video }
  #       else
  #         format.html { render action: 'new' }
  #         format.json { render json: @video.errors, status: :unprocessable_entity }
  #       end
  #     end
  #   else
  #     render json: "Access not authorized"
  #   end
  # end

  # private
  #   def video_params
  #     params.require(:video).permit(:link)
  #   end
end
