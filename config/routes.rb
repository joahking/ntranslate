Ntranslate::Application.routes.draw do
  resources :projects do
    resources :text_resources
    get "translate" => 'text_resources#show', :first => true
  end

  match '/auth/:provider/callback', :to => 'sessions#create'
  match "/signout" => "sessions#destroy", :as => :signout

  root :to => "home#index"
end
