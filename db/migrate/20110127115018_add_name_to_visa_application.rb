class AddNameToVisaApplication < ActiveRecord::Migration
  def self.up
    add_column :visa_applications, :name, :string
  end

  def self.down
    remove_column :visa_applications, :name
  end
end
