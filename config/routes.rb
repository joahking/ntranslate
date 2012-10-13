Ntranslate::Application.routes.draw do
  devise_for :users

# authenticated :user do
    root :to => 'projects#index'

    resources :users

    resources :projects do
      resources :text_resources
      get "translate" => 'text_resources#show', :first => true
    end
#  end


  match '/auth/:provider/callback', :to => 'sessions#create'
  match "/signout" => "sessions#destroy", :as => :signout
  root :to => "home#index"
end
