class Notifier < ActionMailer::Base
  default from: "from@example.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifier.welcome.subject
  #
  def welcome
    @greeting = "Hi"

    mail to: "naveenagarwal287@gmail.com"
  end
end
