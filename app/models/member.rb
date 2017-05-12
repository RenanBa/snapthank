class Member < ApplicationRecord
  validates :email, :name, presence: true
end
