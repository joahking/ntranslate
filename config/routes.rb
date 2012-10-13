Ntranslate::Application.routes.draw do
  resources :user_projects

  resources :users

  resources :projects do
    resources :text_resources
    member do
      get "export", :to => "exports#index"
      scope ':locale' do
        resources :translations, :only => [:index, :create]
      end
    end
  end

  match '/auth/:provider/callback', :to => 'sessions#create'
  match "/signout" => "sessions#destroy", :as => :signout

  root :to => "projects#index"
end
