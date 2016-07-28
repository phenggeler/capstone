Rails.application.routes.draw do
  resources :domains
  resources :authors
  
  resources :author_sessions, only: [ :new, :create, :destroy ]

  get 'login'  => 'author_sessions#new'
  get 'logout' => 'author_sessions#destroy'
  
  root 'domains#new'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
