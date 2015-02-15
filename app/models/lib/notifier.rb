module Notifier
  extend self

  API_KEY = "AIzaSyAL1LGzmtJF00Z5F0KDdZ2UIohu0RU5YlM"

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
      data: msg.merge!({'vibrate': 1, 'sound': 1})
    }
    gcm.send(reg_ids, options)
  end
end

