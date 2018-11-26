class ActionDispatch::Routing::Mapper
  def draw routes_name
    instance_eval(File.read(Rails.root.join("config/routes/#{routes_name}.rb")))
  end
end

Rails.application.routes.draw do
  devise_for :users, only: :omniauth_callbacks, controllers: {omniauth_callbacks: "users/omniauth_callbacks"}
  draw :api
  scope "(:locale)", locale: /en|vi/ do
    root "home#index"
    post "/newcomment", to: "courses#newcomment", as: "newcomment"
    resources :search, only: :index
    resources :categories, only: :show
    resources :courses do
      resources :lessons
    end
    resources :comments, only: :update
    resources :cart_items
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
