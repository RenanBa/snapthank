class Donor < ApplicationRecord
  has_many :videos, dependent: :destroy
  validates :name, :email, :donation, presence: true

  def destroy_donor(donor)
    5.times{p "Destroying donor"}
    session[:donor_key] = nil
    session[:id_donor] = nil
    donor.destroy
  end
end
