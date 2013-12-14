module VisaApplicationTracker
  class UkApplication < VisaApplicationTracker::VisaApplication

    def intern_status
      case status
        when /closed/
          :closed
        else
          :open
      end
    end

    def fetch_status
      #TODO: Remove VERIFY_NONE when they fix their certificate.
      page = Mechanize.new{|a| a.verify_mode = OpenSSL::SSL::VERIFY_NONE}.get('https://www.vfs.org.in/UKG-PassportTracking/ApplicantTrackStatus.aspx?Data=zB/rldwRJCtWdUiUjektSA==')
      result_page = page.form_with(:name => "form1") do |f|
        f.txtDat = @date_of_birth.day
        f.txtMont = @date_of_birth.month
        f.txtYea = @date_of_birth.year
        f.txtRefNO = @reference_number
      end.click_button
      result_page.search("#lblScanStatus").inner_text
    end

    def self.flag
      'gb'
    end

    def self.reference_number_valid?(reference_number)
      reference_number =~ %r{\w{4}/\d{6}/\d{6}/\d}
    end

  end
end
