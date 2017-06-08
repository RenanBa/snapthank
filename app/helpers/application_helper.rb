module ApplicationHelper
  def request_ip(ip)
    (0..ENV["IP"].split().length).each {|i| return true if ip == ENV["IP"].split()[i]}
    return false
  end
end
