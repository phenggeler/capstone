Rails.application.routes.draw do
  resources :domains do 
    collection do
        get 'facebook'
    end
  end
  
  post "oauth/callback" => "oauths#callback"
  get "oauth/callback" => "oauths#callback" # for use with Github, Facebook
  get "oauth/:provider" => "oauths#oauth", :as => :auth_at_provider

  resources :users
  resources :watchers
  resources :user_sessions, only: [ :new, :create, :destroy ]

  get 'login'  => 'user_sessions#new'
  get 'logout' => 'user_sessions#destroy'
  
  root 'user_sessions#new'
  
  namespace :api do
    namespace :v1 do
      # normal route commands go in here!
      # for instance,
      resources :domains, only: [:index, :show, :create, :new, :destroy]
      resources :watchers, only: [:index, :show, :create, :new, :destroy]
    end
  end
  
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
