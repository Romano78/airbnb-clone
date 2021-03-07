Rails.application.routes.draw do
  root to: 'pages#home'
  devise_for :users
  resources :users, only: [:show]
  resources :flats do
    resources :bookings, only: %i[new create]
  end

  resources :bookings, only: %i[edit update destroy]

  get '/dashboard', to: 'pages#dashboard', as: :dashboard
end
