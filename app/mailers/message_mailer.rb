class MessageMailer < ApplicationMailer
  # message_me method
  default :to => "bzanth@gmail.com"
  def message_me(msg)
    @msg = msg

    mail from: @msg.email, subject: @msg.subject, body: @msg.content
  end
end
