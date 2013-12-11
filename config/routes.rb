UkVisa::Application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  visa_types = [:visa_applications,:uk_visa_applications,:dk_visa_applications]
  visa_types.each do |r|
    resources r, :controller => "visa_applications" do#, :only => ['index','show']
      member do
        get 'update_status'
      end
    end
  end
  root :to => 'visa_applications#index'
end
