class VideoUpload < ActiveType::Object
  attribute :file, :varchar
  attribute :title, :varchar
  attribute :description, :text

  validates :file, presence: true
  validates :title, presence: true
end
