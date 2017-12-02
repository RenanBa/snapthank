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

  def schedule
   # aqui vai checar qual é o dia atual e ver quantas horas falta para o proximo envio de emails
   # depois de calcular quantas horas falta para o dia do delivery, calcular para o delivery ser feito as 12:pm

   # se a hora for maior que 12pm reduzir o tempo necessario para o envio ser feito as 12pm
   # se a hora for menor que 12pm adicionar o tempo necessario para o envio ser feito as 12pm

    t = Time.now

    if t.sunday?
      # 48 hours to Tuesday
      return total_minutes(48, t.hour, t.min)
    elsif t.monday?
      # 24 hours to Tuesday
      return total_minutes(24, t.hour, t.min)
    elsif t.tuesday?
      # 48 hours to Thursday
      return total_minutes(48, t.hour, t.min)
    elsif t.wednesday?
      # 24 hours to Thursday
      return total_minutes(24, t.hour, t.min)
    elsif t.thursday?
      # 120 hours to Tuesday
      return total_minutes(120, t.hour, t.min)
    elsif t.friday?
      # 96 hours to Tuesday
      return total_minutes(96, t.hour, t.min)
    elsif t.saturday?
      # 72 hours to Tuesday
      return total_minutes(72, t.hour, t.min)
    end
  end

  def total_minutes(hoursDiff, hoursNow, total_minutes)
    if (hoursNow > 12)
        hoursPassedTwelve = hoursNow - 12
        totalHours = hoursDiff - hoursPassedTwelve
        return (totalHours * 60) - total_minutes
      elsif (hoursNow < 12)
        hoursToTwelve = 12 - hoursNow
        totalHours = hoursDiff + hoursPassedTwelve
        return (totalHours * 60) - total_minutes
      else
        return (hoursDiff * 60) - total_minutes
      end
  end

end
