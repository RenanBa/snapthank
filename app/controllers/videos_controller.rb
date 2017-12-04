class VideosController < ApplicationController

  def index
    @video = Video.new
    @time = Time.new
  end

  # def new
  #   # @video_upload = Video.new
  # end

  def create
    3.times{p "VIDEO CREATE"}
    @donor = Donor.find(params[:donor_id])
    @video_upload = @donor.videos.create(title: params[:title],
                                    description: params[:description],
                                    file: params[:webmasterfile].try(:tempfile).try(:to_path))
    if @video_upload.save
      3.times{p "SAVED"}
      uploaded_video = @video_upload.upload!(current_user)
      if uploaded_video.failed?
        flash[:error] = 'There was an error while uploading your video...'
        redirect_to root_url
      else
        3.times{p "creating link"}
        @video_upload.update!(link: uploaded_video.id)
        respond_to do |format|
          UserMailer.thanks_email(@donor, @video_upload).deliver_later(wait: schedule.minutes)
          format.html { redirect_to(root_url, notice: 'Uploaded Successfully!') }
          format.json { render json: @video_upload, status: :created, location: @video_upload }
        end
      end
      session[:user_id] = nil
      session[:donor_key] = nil
      session[:id_donor] = nil
    else
      redirect_to(@donor, notice: "video wasn't uploaded.")
    end
  end
  # private
  #   def video_params
  #     params.require(:video).permit(:link)
  #   end
end
