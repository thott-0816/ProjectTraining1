require "api_constraints"
namespace :api, defaults: {format: "json"} do
  scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
    post "/login", to: "sessions#create"
    post "/signup", to: "users#create"
    resources :categories, only: [:index, :show]
    resources :courses, only: [:show]
    resources :users, only: [:create]
  end
end
