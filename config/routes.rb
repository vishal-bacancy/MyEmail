Rails.application.routes.draw do
  resources :emails do 
    get "delete_from_show"
  end
  devise_for :users,  :controllers => {:registrations => "users/registrations"}
  resources :users
  resources :groups
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "emails#index"
end
