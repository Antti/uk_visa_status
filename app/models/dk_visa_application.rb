class DkVisaApplication < VisaApplication
  validates :reference_number, :format => %r{\w{4}/\d{6}/\d{4}}
  def fetch_new_status
    page = Mechanize.new.get("https://www.visaservices.firm.in/Denmark-Global-Tracking/TrackingParam.aspx?P=xTsyV66sjtxnpCJBo4njvBlHEVb7OmzOTHTEx9q1H7Y=")
    result_page = page.form_with(:name => "aspnetForm") do |f|
      rn = reference_number.split("/")
      f.send("ctl00$CPH$txtR2Part1=",rn[0])
      f.send("ctl00$CPH$txtR2Part2=",rn[1])
      f.send("ctl00$CPH$txtR2Part3=",rn[2])
      f.send("ctl00$CPH$txtDOB$txtDate=",date_of_birth.strftime("%d/%m/%Y"))
    end.click_button
    result_page.search("td.fnstatus table td").inner_text
  end

  def self.flag
    'dk'
  end

  def parse_status
    self.status = case status_text
    when /has been delivered over the counter/
      'closed'
    end
  end
end