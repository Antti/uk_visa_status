class VisaApplication < ActiveRecord::Base
  self.include_root_in_json = false
  attr_accessible :type,:name,:reference_number,:date_of_birth
  validates :name, :presence => true
  validates :reference_number, :presence => true

  scope :not_closed, where("status != 'closed'")
  def update_status
    return false if self.closed?
    self.status_text = fetch_new_status
    if changed?
      parse_status
      options = if self.notify_email && !self.notify_email.empty?
        {:to => self.notify_email}
      else
        {}
      end
      VisaApplicationStatusMailer.status_updated(self, changes,options).deliver
    end
    self.save
  end

  def flag
    self.class.flag
  end
  def closed?
    status == 'closed'
  end
  def parse_status
    raise 'Not implemented'
  end
end
