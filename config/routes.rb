Rails.application.routes.draw do
  root 'mypages#index'

  resources :posts
  resources :mypages, only: [:index]

  devise_for :users
end
