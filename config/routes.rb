Ntranslate::Application.routes.draw do
  devise_for :users

  authenticated :user do
    root :to => 'projects#index'

    resources :users

    resources :projects do
      resources :text_resources
    end
  end

  root :to => "home#index"
end
