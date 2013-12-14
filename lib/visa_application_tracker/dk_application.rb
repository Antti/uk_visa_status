module VisaApplicationTracker
  class DkApplication < VisaApplicationTracker::VisaApplication

    def intern_status
      case status
        when /has been delivered over the counter/
          'closed'
        else
          'open'
      end
    end

    def fetch_status
      page = Mechanize.new.get("https://www.visaservices.firm.in/Denmark-Global-Tracking/TrackingParam.aspx?P=xTsyV66sjtxnpCJBo4njvBlHEVb7OmzOTHTEx9q1H7Y=")
      result_page = page.form_with(:name => "aspnetForm") do |f|
        rn = reference_number.split("/")
        f.send("ctl00$CPH$txtR2Part1=", rn[0])
        f.send("ctl00$CPH$txtR2Part2=", rn[1])
        f.send("ctl00$CPH$txtR2Part3=", rn[2])
        f.send("ctl00$CPH$txtDOB$txtDate=", date_of_birth.strftime("%d/%m/%Y"))
      end.click_button
      result_page.search("td.fnstatus table td").inner_text
    end

    def self.flag
      'dk'
    end

    def self.reference_number_valid?(reference_number)
      reference_number =~ %r{\w{4}/\d{6}/\d{4}}
    end
  end
end
