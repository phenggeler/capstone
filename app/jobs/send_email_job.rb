class SendEmailJob < ApplicationJob
  queue_as :default

  def perform(*args)
    @author = author
    UserMailer.welcome_email(@author).deliver_later
  end
end
