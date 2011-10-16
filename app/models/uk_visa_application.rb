class UkVisaApplication < VisaApplication
  validates :reference_number, :format => %r{\w{4}/\d{6}/\d{6}/\d}
  def fetch_new_status
    page = Mechanize.new.get("https://www.vfs.org.in/Ukg-PassportTracking/ApplicantTrackStatus.aspx?Data=zB/rldwRJCtWdUiUjektSA%3d%3d")
    result_page = page.form_with(:name => "form1") do |f|
      f.txtDat = date_of_birth.day
      f.txtMont = date_of_birth.month
      f.txtYea = date_of_birth.year
      f.txtRefNO = reference_number
    end.click_button
    result_page.search("#lblScanStatus").inner_text
  end

  def self.flag
    'gb'
  end

  def parse_status
    self.status = case status_text
    when /Case closed/
      'closed'
    end
  end
end