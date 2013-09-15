class VisaApplicationStatusMailer < ActionMailer::Base
  default :from => "Andriy's Dmytrenko bot <andrey@reevoo.com>", :to => "Andriy Dmytrenko <andm@ciklum.net>"

  def status_updated(visa_application, changes, options={})
    @visa_application = visa_application
    @changes = changes
    options[:to] = visa_application.notify_email if visa_application.notify_email.present?
    options[:subject] = "Visa Application Status changed"
    mail(options)
  end
end
