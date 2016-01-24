class MessageMailer < ApplicationMailer
  # message_me method
  # TODO : change this email to teamtaskandgo@gmail.com for Production.ENV
  default :to => "teamtaskandgo+ContactUs@gmail.com" # change to teamtaskandgo@gmail.com in production used

  # the below default from: is overwritten by gmail smtp use standards.
  default from: "TeamTaskandGo <noreply@taskandgo.com>" # added to test # doesn't work overitten by gmail
  # TODO : incorporate a working layout for emails sent to site_email Layout below fails
  # layout 'message_me' # not showing up yet as spec'd in docs

  # message_me method : We tie plain:text all data within
  # the body and name @ email says subject in # subject line
  def message_me(msg)
    @msg = msg
    mail subject: "From: #{@msg.name} : #{@msg.email} says : #{@msg.subject}", body: "From: #{@msg.name} @ #{@msg.email} | Subject: #{@msg.subject} | Body of email : #{@msg.content}"
    #@msg.content << "From : #{@msg.name} :: Subject : #{@msg.subject}" # previous one
  end
end
