Rails.application.routes.draw do
  resources :domains do 
    collection do
        get 'facebook'
    end
  end
  
  resources :signups do 
    collection do
        get 'pending'
    end
  end
  
  #resources :signups
  resources :authors
  resources :watchers
  resources :author_sessions, only: [ :new, :create, :destroy ]

  get 'login'  => 'author_sessions#new'
  get 'logout' => 'author_sessions#destroy'
  
  root 'author_sessions#new'
  
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
