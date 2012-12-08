class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from Exception, :with => :server_error
  def server_error(exception)
   puts "Put your sms sending code here"
   ExceptionNotifier::Notifier.exception_notification(request.env, exception).deliver
  end
end
