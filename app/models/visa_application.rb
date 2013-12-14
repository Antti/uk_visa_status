class VisaApplication < ActiveRecord::Base
  self.include_root_in_json = false
  validates :name, :presence => true
  validates :reference_number, :presence => true
  validate :check_reference_number_format

  scope :not_closed, -> { where("status != 'closed'") }

  def update_status!
    return false if self.closed?
    self.status_text = application_tracker.status
    if changed?
      self.status = application_tracker.intern_status
      self.save!
      VisaApplicationStatusMailer.status_updated(self, changes).deliver
    end
  end

  def closed?
    status == 'closed'
  end

  def flag
    application_type_klass.flag
  end

  private

  def check_reference_number_format
    application_type_klass.reference_number_valid? reference_number
  end

  def application_tracker
    @application_tracker ||= application_type_klass.new(reference_number, date_of_birth)
  end

  def application_type_klass
    "VisaApplicationTracker::#{application_type}".constantize
  end

end
