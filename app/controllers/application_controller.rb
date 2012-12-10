class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from Exception, :with => :server_error
  def server_error(exception)
   send_sms
   #ExceptionNotifier::Notifier.exception_notification(request.env, exception).deliver
  end

  def send_sms
    api_key = 'DFL447ZTDKUTH2QR6XRXRGGGTX9PLWA2'
    project_id = 'PJ7b0019a122e59c4539e88b3072041a7d'
    phone_id = 'PN94fdd2eeec254cdc1de0177fc395aefb'
    to_number = '+918800576579'
    content = 'An Excaption occured'

    require 'net/https'
    require 'json'

    uri = URI("https://api.telerivet.com/v1/projects/#{project_id}/messages/outgoing")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_PEER

    # you will need to download SSL certificates from https://telerivet.com/_media/cacert.pem .
    http.ca_file = File.join(Rails.root, "cacert.pem")

    http.start {
        req = Net::HTTP::Post.new(uri.path)
        req.form_data = {
            "content" => content,
            "phone_id" => phone_id,
            "to_number" => to_number,
        }
        req.basic_auth api_key, ''

        res = JSON.parse(http.request(req).body)

        puts "**********************\n#{res}\n***************************"   # do something with res
    }
  end
end
