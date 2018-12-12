Rails.application.routes.draw do
  root 'home#index'

  resources :posts
  resources :mypages, only: [:show]
  resources :friends, only: [:create, :show] do
    member do
      get :add_friend, as: 'add', defaults: { format: 'js' }
      delete :delete_friend, as: 'delete'
    end
  end
  resources :user_alarms, only: [:show] do
    member do
      post :allow_friend
      delete :reject_friend
      delete :cancel_friend
      delete :delete_alarm, as: 'delete'
    end
  end

  devise_for :users
end
