class Member < ApplicationRecord
  validates :email, presence: true
end
