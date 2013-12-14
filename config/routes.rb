UkVisa::Application.routes.draw do
  devise_for :users, :controllers => {:omniauth_callbacks => "users/omniauth_callbacks"}


  resources :visa_applications do #, :only => ['index','show']
    member do
      get 'update_status'
    end
  end

  root :to => 'visa_applications#index'
end
