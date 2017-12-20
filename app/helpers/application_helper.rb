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

  def self.schedule
    # The schedule method will calculate how many minutes are left for the next
    # delivery. The delivery are scheduled to Tuesday and Thursday at 12:00 pm.
    # The emails that are sent on the delivery day, independent of the time, will
    # be scheduled to the next delivery day

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

  def total_minutes(hoursDiff, hoursNow, minutes)
    # hoursDiff is the amount of days in hours to the next deliver day
    # hoursNow and minutes are the exactly time that the schedule method is trigged
    if (hoursNow > 12)
        hoursPassedTwelve = hoursNow - 12
        totalHours = hoursDiff - hoursPassedTwelve
        return (totalHours * 60) - minutes
      elsif (hoursNow < 12)
        hoursToTwelve = 12 - hoursNow
        totalHours = hoursDiff + hoursToTwelve
        return (totalHours * 60) - minutes
      else
        return (hoursDiff * 60) - minutes
      end
  end

end
