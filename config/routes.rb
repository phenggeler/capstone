Rails.application.routes.draw do
  resources :domains
  resources :authors
  resources :watchers
  resources :author_sessions, only: [ :new, :create, :destroy ]

  get 'login'  => 'author_sessions#new'
  get 'logout' => 'author_sessions#destroy'
  
  root 'domains#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
