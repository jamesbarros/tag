class MessagesController < ApplicationController

  def new
    @message = Message.new
  end

  def create
    @message = Message.new(message_params)

    if @message.valid? # added delay prior message_me() to tie in delayed_jobs
      MessageMailer.delay.message_me(@message)#.deliver_now # remove delay to uncomment deliver_now
      redirect_to new_message_path, notice: "Your message has been sent, thanks you."
    else
      render :new
    end
  end


  private

  def message_params
    params.require(:message).permit(:name, :email, :subject, :content)
  end
end
