class Donor < ApplicationRecord
  has_many :videos, dependent: :destroy
  validates :first_name, :email, :donation, presence: true

  def self.destroy_donor(donor, video)
    5.times{p "Donor #{donor}" }
    5.times{p "Video #{video}"}
  end
end
