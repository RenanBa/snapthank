class VideoUploadsController < ApplicationController
  def new
    @video_upload = VideoUpload.new
  end

  def create
  end
end
