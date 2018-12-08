Rails.application.routes.draw do
  root 'mypages#index'

  resources :posts

  devise_for :users
end
