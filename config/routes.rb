Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :cars do
    resources :bookings, only: [:new, :create]
    resources :reviews, only: [:index, :show]
  end

  resources :users, except: :index do
    # A user needs to be able to see his bookings and a particular booking
  end

  resources :bookings, only: [:index, :show, :destroy] do
    resources :reviews, only: [:new, :create]
  end

  resources :reviews, only: :destroy
end
