Rails.application.routes.draw do
  root 'posts#index'
  devise_for :users

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :profiles, except: [:destroy]
  resources :posts do
    resources :comments, except: [:show, :index]
  end
  resources :likes, only: [:create, :destroy]
  resources :follows, only: [:create, :edit, :update, :destroy]

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check
end
