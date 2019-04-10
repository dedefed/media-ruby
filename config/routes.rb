Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "pages#home"
  get "about", to: "pages#about"
  resources :articles
  resources :categories
  post "register", to: "users#create"
  post '/auth/login', to: 'authentications#login'
  resources :users, except: [:new]
  resources :categories
end
