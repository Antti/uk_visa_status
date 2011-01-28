class VisaApplication < ActiveRecord::Base
  self.include_root_in_json = false
  attr_accessible :type,:name,:reference_number,:date_of_birth
  validates :name, :presence => true
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
