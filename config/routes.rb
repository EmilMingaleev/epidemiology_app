Rails.application.routes.draw do
  get "users/show"
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users

  root "home#index"

  get "epidemiology_recommendations", to: "epidemiology#show", as: :epidemiology_recommendations

  resources :departments do
    resources :reports, only: [:new, :create]
  end

  resources :users, only: [:index]
end
