class Donor < ApplicationRecord
  has_many :videos, dependent: :destroy
  validates :first_name, :email, :donation, presence: true

  def self.destroy_donor(donor)
    5.times{p "Destroying donor"}
    # session[:donor_key] = nil
    # session[:id_donor] = nil
    # donor.destroy
    5.times{p "Donor object =>" + donor}
    yield
    10.times{p "Back to destroy_donor!!!"}
  end
end
