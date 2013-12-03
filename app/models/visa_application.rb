class VisaApplication < ActiveRecord::Base
  self.include_root_in_json = false
#  attr_accessible :type,:name,:reference_number,:date_of_birth, :notify_email
  validates :name, :presence => true
  validates :reference_number, :presence => true

  scope :not_closed, -> { where("status != 'closed'") }

  before_save do
    self.status = "open" if new_record?
  end

  def update_status
    return false if self.closed?
    self.status_text = fetch_new_status
    if changed?
      parse_status
      VisaApplicationStatusMailer.status_updated(self, changes).deliver
      self.save
    end
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
