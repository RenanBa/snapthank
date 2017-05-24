class VideoUploadsController < ApplicationController
  def new
    @video_upload = VideoUpload.new
  end

  def create
    @video_upload = VideoUpload.new(title: params[:video_upload][:title],
                                  description: params[:video_upload][:description],
                                  file: params[:video_upload][:file].try(:tempfile).try(:to_path))
    if @video_upload.save
      uploaded_video = @video_upload.upload!(current_user)

      # check if the video was uploaded or not

      redirect_to root_url
    else
      render :new
    end
  end
end
