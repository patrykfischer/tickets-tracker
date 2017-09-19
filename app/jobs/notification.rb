class Notification < ActiveJob::Base
  queue_as :default

  def perform(email)
    # push_notification / send message
  end
end
