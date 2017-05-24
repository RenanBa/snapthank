class Video < ApplicationRecord
  # belongs_to :donor
  attribute :file, :varchar
  attribute :title, :varchar
  attribute :description, :text

  validates :file, presence: true
  validates :title, presence: true

  YT_LINK_FORMAT = /\A.*(youtu.be\/|v\/|u\/\w\/|embed\/|watch\?v=|\&v=)([^#\&\?]*).*/i
  validates :link, presence: true, format: YT_LINK_FORMAT

  def upload!(user)
    account = Yt::Account.new access_token: user.token
    account.upload_video self.file, title: self.title, description: self.description
  end

  def self.before_save(resource)
    video = Yt::Video.new url: resource.link
    resource.uid = video.id
    resource.title = video.title
    resource.likes = video.like_count
    resource.dislikes = video.dislike_count
    resource.published_at = video.published_at
  rescue Yt::Errors::NoItems
    resource.title = ''
  end

end
