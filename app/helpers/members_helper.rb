module MembersHelper

  def request_ip(ip)
    if ip == ENV['IP']
      return true
    else
      return false
    end
  end
end
