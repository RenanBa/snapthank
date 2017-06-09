class Donor < ApplicationRecord
  has_many :videos, dependent: :destroy
  validates :first_name, :email, :donation, presence: true

  def self.destroy_donor(donor, video)
    5.times{p "Destroy Donor"}
    5.times{p "Video"}
    yield
    10.times{p "Back to destroy_donor!!!"}
  end
end
