class AddNotificationEmailToVisaApplication < ActiveRecord::Migration
  def self.up
    add_column :visa_applications, :notify_email, :string
  end

  def self.down
    drop_column :visa_applications, :notify_email
  end
end
