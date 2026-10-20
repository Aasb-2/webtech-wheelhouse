Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  root "pages#home"
  get "visiting", to: "pages#visiting", as: :visiting
  get "about", to: "pages#about", as: :about

  namespace :api do
  namespace :v1 do
    resources :services, only: [:index, :show, :create]
    resources :repairs, only: [:index, :show]
  end
end

  resources :customers
  resources :bikes
  resources :repairs do
    resources :photos, only: :destroy, controller: "repair_photos"
  end
  resources :mechanics
  resources :service_items, path: "services"
end