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
    # t = t + 24*60*60
    if t.sunday?
      # to Tuesday
      # 48
      # return {Wday: "sunday", hour: t.hour, month: t.month, minutes: t.min, mDay: t.day}
    elsif t.monday?
      # to Tuesday
      # 24
      # return {Wday: "monday", hour: t.hour, month: t.month, minutes: t.min, mDay: t.day}
    elsif t.tuesday?
      # if the email is before 12pm schedule to the same day
      # else if the email is after 12pm schedule to Thursday
      # return {Wday: "tuesday", hour: t.hour, month: t.month, minutes: t.min, mDay: t.day}
    elsif t.wednesday?
      # to Thursday
      # 24
      # return {Wday: "wednesday", hour: t.hour, month: t.month, minutes: t.min, mDay: t.day}
    elsif t.thursday?
      # if the email is before 12pm schedule to the same day
      # else if the email is after 12pm schedule to Tuesday
      # return {Wday: "thursday", hour: t.hour, month: t.month, minutes: t.min, mDay: t.day}
    elsif t.friday?
      # 96 hours to Tuesday
      if (t.hour > 12)
        hoursPassedTwelve = t.hour - 12
        totalHours = 96 - hoursPassedTwelve
        return totalHours
      elsif (t.hour < 12)
        hoursToTwelve = 12 - t.hour
        totalHours = 96 + hoursPassedTwelve
        return totalHours
      else
        return 96
      end

      # to Tuesday
      # 96
      # return {Wday: "friday", hour: t.hour, month: t.month, minutes: t.min, mDay: t.day}
    elsif t.saturday?
      # to Tuesday
      # 72
      # return {Wday: "saturday", hour: t.hour, month: t.month, minutes: t.min, mDay: t.day}
    end
  end

end
