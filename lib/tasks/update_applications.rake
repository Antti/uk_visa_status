desc "Update visas application status"
task :update_applications => :environment do
  VisaApplication.not_closed.each do |app|
    app.update_status!
  end
end