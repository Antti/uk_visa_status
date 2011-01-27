task :update_applications => :environment do
  VisaApplication.all.each do |app|
    app.update_status
  end
end