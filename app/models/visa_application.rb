class VisaApplication < ActiveRecord::Base
  self.include_root_in_json = false
  attr_accessible :type,:name,:reference_number,:date_of_birth
  validate :reference_number, :format => %r{\w{4}/\d{6}/\d{6}/\d}
  def update_status
    self.status = fetch_new_status
    if changed?
      VisaApplicationStatusMailer.status_updated(self, changes).deliver
    end
    self.save
  end

  def flag
    self.class.flag
  end
end
