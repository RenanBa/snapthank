class VideosController < ApplicationController

  def index
    @videos = Video.order('created_at DESC')
  end

  def new
    10.times{p "Video"}

    @video_upload = Video.new
  end

  def create


    5.times{p "VIDEO CREATE"}
    p params[:title]
    p params[:description]
    p params[:webmasterfile]
    render json: "VideosController"
    5.times{p "VIDEO CREATE"}

      @donor = Donor.find(params[:donor_id])
      @video_upload = @donor.videos.create(title: params[:title],
                                      description: params[:description],
                                      file: params[:webmasterfile].try(:tempfile).try(:to_path))
      respond_to do |format|
        if @video_upload.save
          10.times{p "SAVED"}
          uploaded_video = @video_upload.upload!(current_user)

          if uploaded_video.failed?
            flash[:error] = 'There was an error while uploading your video...'
          else
            10.times{p "creating link"}
            10.times{p uploaded_video.id}
            @video_upload.update!(link: uploaded_video.id)
            # Video.create({link: "https://www.youtube.com/watch?v=#{uploaded_video.id}"})

            UserMailer.thanks_email(@donor, @video_upload).deliver_later
            format.html { redirect_to(@donor, notice: 'video link was successfully created.') }
            format.json { render json: @video_upload, status: :created, location: @video_upload }
            # flash[:success] = 'Your video has been uploaded!'
            # render json:'Your video has been uploaded!'
          end

          redirect_to root_url
        else
          # render :new
          format.html { render action: 'new' }
          format.json { render json: @video_upload.errors, status: :unprocessable_entity }
        end
      end
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


  # This belongs to the action mailer create method which is commented but it
  # is also used for the google api call when a link is add from youtube
  private
    def video_params
      params.require(:video).permit(:link)
    end
end
