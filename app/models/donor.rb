class Donor < ApplicationRecord
  has_many :videos, dependent: :destroy
  validates :name, :email, :donation, presence: true
end
