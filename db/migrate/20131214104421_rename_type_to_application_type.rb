class RenameTypeToApplicationType < ActiveRecord::Migration
  def change
    rename_column :visa_applications, :type, :application_type
    VisaApplication.reset_column_information
    VisaApplication.all.each do |va|
      va.application_type = va.application_type.gsub('Visa','')
      va.save
    end
  end
end
