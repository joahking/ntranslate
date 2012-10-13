Ntranslate::Application.routes.draw do
  devise_for :users

  authenticated :user do
    root :to => 'projects#index'

    resources :users
    resources :projects
  end

  root :to => "home#index"
end
