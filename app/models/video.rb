class Video < ApplicationRecord
  belongs_to :donor
  validates :file, presence: true
  def upload!(user)
    account = Yt::Account.new access_token: user.token
    5.times{ p "video model upload YT"}
    account.upload_video self.file, title: self.title, description: self.description
  end
end
