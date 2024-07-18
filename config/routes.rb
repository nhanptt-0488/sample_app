Rails.application.routes.draw do
  # Defines the root path route ("/")
  scope "(:locale)", locale: /en|vi/ do
    root "static_pages#home"
    get "/help", to: "static_pages#help"
    get "/home", to: "static_pages#home"
    get "/signup", to: "users#new"
    post "/signup", to: "users#create"
    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    delete "/logout", to:"sessions#destroy"
    resources :users
    resources :password_resets, only: %i(new create edit update)
    resources :account_activations, only: :edit
    resources :microposts, only: %i(create destroy)
  end
end
