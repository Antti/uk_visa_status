class DkVisaApplication < VisaApplication
  validate :reference_number, :format => %r{\w{4}/\d{6}/\d{4}}
  def fetch_new_status
    page = Mechanize.new.get("http://www.denmarkvac-ua.com/track.html")
    result_page = page.form_with(:name => "form1") do |f|
      f.txtDat = date_of_birth.day
      f.txtMont = date_of_birth.month
      f.txtYea = date_of_birth.year
      f.txtRefNO = reference_number
    end.click_button
    result_page.search("#lblScanStatus").inner_text
  end
end