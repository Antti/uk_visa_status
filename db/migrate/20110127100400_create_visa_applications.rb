class CreateVisaApplications < ActiveRecord::Migration
  def self.up
    create_table :visa_applications do |t|
      t.string :reference_number
      t.date :date_of_birth

      t.timestamps
    end
  end

  def self.down
    drop_table :visa_applications
  end
end
