Rails.application.routes.draw do
  root to: "welcome#index"
  resources :posts
  resources :projects
  match '/contacts', to: 'contacts#new', via: 'get'
  resources :contacts, only: [:new, :create]
end
