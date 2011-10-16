class AddStatusToVisaApplication < ActiveRecord::Migration
  def change
    rename_column :visa_applications, :status, :status_text
    add_column :visa_applications, :status, :string
  end
end
