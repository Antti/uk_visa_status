class VisaApplicationStatusMailer < ActionMailer::Base
  default :from => "Andriy's Dmytrenko bot <andrey@reevoo.com>", :to => "andm@ciklum.net, khi@ciklum.net"

  def status_updated(visa_application, changes, options={})
    @visa_application = visa_application
    @changes = changes
    mail(:subject => "Visa Application Status changed", options)
  end
end
