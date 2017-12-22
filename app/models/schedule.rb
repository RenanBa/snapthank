class Schedule < ApplicationRecord
  after_initialize :set_sent_status
  def set_sent_status
    self.sent_status = false
  end
end
