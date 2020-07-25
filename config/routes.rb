Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :cars do
    resources :bookings, only: [:new, :create, :show]
    resources :reviews, only: [:index, :show, :new, :create]
  end

  resources :users, except: :index do
    # A user needs to be able to see his bookings and a particular booking
  end

  resources :bookings, only: [:index, :destroy]
  resources :reviews, only: :destroy
end
