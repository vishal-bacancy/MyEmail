Rails.application.routes.draw do
  namespace :emails do
    get "sent"
  end
  namespace :groups do
    get "delete_member"
  end
  resources :emails do 
    get "delete_from_show"
    get "add_to_favourites"
    get "remove_to_favourites"
  end
  resources :favourites ,only: [:index]
  devise_for :users,  :controllers => {:registrations => "users/registrations"}
  resources :users
  resources :groups


  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "emails#index"
end
