class Donor < ApplicationRecord
  has_many :videos, dependent: :destroy
  validates :first_name, :email, :donation, presence: true

  def self.destroy_donor(donor)
    Donor.find(donor).destroy
  end
end
