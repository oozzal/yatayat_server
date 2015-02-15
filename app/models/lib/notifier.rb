module Notifier
  extend self

  API_KEY = "AIzaSyB09h4QtoxL3alFV4JDzArJYDjoltix4r0"

  # msg sample:
  # {
  #   'message': '',
  #   'title': '',
  #   'subtitle': '',
  #   'tickerText': '',
  #   'vibrate': 1,
  #   'sound': 1
  # }
  def notify_all(msg, reg_ids)
    gcm = GCM.new(API_KEY)
    options = {
      data: msg.merge!({vibrate: 1, sound: 1})
    }
    gcm.send(reg_ids, options)
  end
end

