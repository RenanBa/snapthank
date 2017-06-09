module ApplicationHelper
  def request_ip(ip)
    (0..ENV["IP"].split().length).each {|i| return true if ip == ENV["IP"].split()[i]}
    return false
  end

  def logining(name, password)
    return true if ENV["ADMIN_PASSWORD"] == password && ENV["ADMIN_NAME"] == name
    return false
  end

  def delete_donor(donor)
    5.times{p "In the delete_donor helper method"}
    5.times{p "Donor object =>" + donor}
    yield
    10.times{p "Back to delete_donor!!!"}
  end
end
