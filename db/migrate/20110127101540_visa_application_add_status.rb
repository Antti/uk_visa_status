class VisaApplicationAddStatus < ActiveRecord::Migration
  def self.up
    add_column :visa_applications, :status, :string
  end

  def self.down
    add_column :visa_applications, :status
  end
end
