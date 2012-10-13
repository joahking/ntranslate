Ntranslate::Application.routes.draw do
  resources :users

  resources :projects do
    resources :text_resources
    get "translate" => 'text_resources#translate', :first => true
  end

  match '/auth/:provider/callback', :to => 'sessions#create'
  match "/signout" => "sessions#destroy", :as => :signout

  root :to => "projects#index"
end
