class Emailer < ActionMailer::Base
  default from: 'app.yatayat@gmail.com'

  def send_mail(to, subject, message)
    mail(to: to, subject: subject) do |format|
      format.text { render text: message }
    end
  end

end

