module MembersHelper

  def request_ip(ip)
    (0..ENV["IP"].split().length).each do |i|
      ip == ENV["IP"].split()[i] ? (return true) : (return false)
    end
  end
end
