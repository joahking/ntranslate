Ntranslate::Application.routes.draw do
  resources :user_projects, :only => [:index]

  resources :users do
    resources :user_projects, :only => [:edit, :update]
  end

  resources :projects do
    resources :text_resources
    member do
      get "export", :to => "exports#index"
      scope ':locale', :constraints => {:locale => /[a-z]{2}/} do
        resources :translations, :only => [:index, :create]
      end
    end
  end

  match '/auth/:provider/callback', :to => 'sessions#create'
  match "/signout" => "sessions#destroy", :as => :signout

  get '/home', :to => "home#index", :as => :home

  root :to => "projects#index"
end
