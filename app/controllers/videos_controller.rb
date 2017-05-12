class VideosController < ApplicationController
   def create
    if request_ip(request.ip)
      @donor = Donor.find(params[:donor_id])
      @video = @donor.videos.create(video_params)
      if @video.save
      # redirect_to article_path(@donor)
      render :json => {:message => "The link #{@video.link} to video was created for the donor: #{@donor.name}"}.to_json
    else
      render :json => {:message => "Video not created!"}
    end
    else
      render json: "Access not authorized"
    end
  end

  private
    def video_params
      params.require(:video).permit(:link)
    end
end
