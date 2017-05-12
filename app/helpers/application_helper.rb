module ApplicationHelper
  def request_ip(ip)
    (0..ENV["IP"].split().length).each do |i|
      ip == ENV["IP"].split()[i] ? (return true) : (return false)
    end
  end

  def permission(member)
    (0..ENV["PERMISSIONS"].split().length).each do |i|
      member == ENV["PERMISSIONS"].split()[i] ? (return true) : (return false)
    end
  end
end
