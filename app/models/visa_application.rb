class VisaApplication < ActiveRecord::Base
  self.include_root_in_json = false
  validate :reference_number, :format => %r{\w{4}/\d{6}/\d{6}/\d}
  def update_status
    self.status = fetch_new_status
    if changed?
      VisaApplicationStatusMailer.status_updated(self, changes).deliver
    end
    self.save
  end
end
