require "api_constraints"
namespace :api, defaults: {format: "json"} do
  scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
    post "/login", to: "sessions#create"
    resources :courses, only: %i(index)
  end
end
