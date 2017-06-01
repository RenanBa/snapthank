class Donor < ApplicationRecord
  has_many :videos, dependent: :destroy
end
