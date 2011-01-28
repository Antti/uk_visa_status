UkVisa::Application.routes.draw do
  visa_types = [:visa_applications,:uk_visa_applications,:dk_visa_applications]
  visa_types.each do |r|
    resources r, :controller => "visa_applications" do#, :only => ['index','show']
      member do
        get 'update_status'
      end
    end
  end
=begin
  scope "/admin" do
     visa_types.each do |r|
       resources r, :controller => "visa_applications" do
         member do
           get 'update_status'
         end
       end
     end
  end
=end
  root :to => 'visa_applications#index'
end
