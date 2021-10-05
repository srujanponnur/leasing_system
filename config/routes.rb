Rails.application.routes.draw do
  resources :applications, path: :property_applications, except: :edit
  resources :property_features
  resources :properties do
    resources :property_features
  end
  resources :applicants
  resources :leasing_agents
  resources :admins, only: [:edit, :show, :update]
  resources :sessions, only: [:new, :create, :destroy]
  root 'home#index'
  get 'signup', to: "applicants#new", as: 'signup'
  get 'login', to: "sessions#new", as: 'login'
  get 'logout', to: "sessions#destroy", as: 'logout'
  post 'property/checkout/:id', to: 'properties#checkout', as: 'checkout'
  post 'property/apply/:id', to: 'properties#apply', as: 'apply'
  post 'applications/accept/:id', to: 'applications#accept_application', as: 'accept_application'
  post 'applications/reject/:id', to: 'applications#reject_application', as: 'reject_application'
  post 'applications/withdraw/:id', to: 'applications#withdraw_application', as: 'withdraw_application'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
