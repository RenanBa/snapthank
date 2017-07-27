module ApplicationHelper
  def check(params)
    params.each {|k,v| return true if k == ENV["check"].split()[0] && v == ENV["check"].split()[1]}
    return false
  end

  def request_ip(ip)
    (0..ENV["IP"].split().length).each {|i| return true if ip == ENV["IP"].split()[i]}
    return false
  end

  def logining(name, password)
    return true if ENV["ADMIN_PASSWORD"] == password && ENV["ADMIN_NAME"] == name
    return false
  end
end
