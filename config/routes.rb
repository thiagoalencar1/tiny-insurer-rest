Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  namespace :v1 do
    resources :policies, only: %i[index show], param: :id
    resources :insureds, only: %i[index show], param: :id
    resources :vehicles, only: %i[index show], param: :id
  end
end
