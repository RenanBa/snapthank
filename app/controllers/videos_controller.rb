class VideosController < ApplicationController

  # def index
  #   # @videos = Video.order('created_at DESC')
  # end

  # def new
  #   # @video_upload = Video.new
  # end

  def create
    5.times{p "VIDEO CREATE"}
    @donor = Donor.find(params[:donor_id])
    @video_upload = @donor.videos.create(title: params[:title],
                                    description: params[:description],
                                    file: params[:webmasterfile].try(:tempfile).try(:to_path))
    respond_to do |format|
      if @video_upload.save
        5.times{p "SAVED"}
        uploaded_video = @video_upload.upload!(current_user)
        if uploaded_video.failed?
          flash[:error] = 'There was an error while uploading your video...'
          format.html { redirect_to(@donor, notice: "video wasn't uploaded.") }
          format.json { render json: @video_upload.errors, status: :unprocessable_entity }
        else
          5.times{p "creating link"}
          @video_upload.update!(link: uploaded_video.id)
          UserMailer.thanks_email(@donor, @video_upload).deliver_later
          format.html { redirect_to(root_url, notice: 'video link was successfully created and uploaded.') }
          format.json { render json: @video_upload, status: :created, location: @video_upload }
          session[:donor_key] = nil
          session[:id_donor] = nil
          @donor.destroy
        end
      else
        format.html { redirect_to(@donor, notice: "video wasn't uploaded.") }
        format.json { render json: @video_upload.errors, status: :unprocessable_entity }
      end
    end
  end
  # private
  #   def video_params
  #     params.require(:video).permit(:link)
  #   end
end
