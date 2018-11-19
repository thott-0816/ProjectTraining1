Rails.application.routes.draw do
  devise_for :users, only: :omniauth_callbacks, controllers: {omniauth_callbacks: "users/omniauth_callbacks"}
  scope "(:locale)", locale: /en|vi/ do
    root "home#index"
    post "/newcomment", to: "courses#newcomment", as: "newcomment"
    resources :search, only: :index
    resources :courses do
      resources :lessons
    end
    resources :comments, only: :update
    devise_for :users, controllers: { registrations: "users/registrations", sessions: "users/sessions",
    passwords: "users/passwords"}, skip: :omniauth_callbacks
    resources :users, only: :show

    namespace :admin do
      resources :users
      resources :categories
      resources :courses do
        resources :lessons
      end
      get "/", to: "dashboards#index"
    end
  end
end
