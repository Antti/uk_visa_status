class AddTypeToVisaApplication < ActiveRecord::Migration
  def self.up
    add_column :visa_applications, :type, :string
  end

  def self.down
    remove_column :visa_applications, :type
  end
end
