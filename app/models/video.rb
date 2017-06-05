class Video < ApplicationRecord
  belongs_to :donor
  validates :file, presence: true
  def upload!(user)
    5.times{ p "Model Upload"}
    account = Yt::Account.new access_token: user.token
    account.upload_video self.file, title: self.title, description: self.description, privacy_status: "unlisted"
  end
end
