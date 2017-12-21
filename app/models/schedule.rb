class Schedule < ApplicationRecord
  after_initialize :set_sent_default_status
  def set_sent_default_status
    self.sent = false
  end
end
