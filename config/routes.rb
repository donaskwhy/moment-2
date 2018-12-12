Rails.application.routes.draw do
  root 'home#index'

  resources :posts
  resources :mypages, only: [:show]
  resources :friends, only: [:create, :show] do
    member do
      get :add_friend, as: 'add', defaults: { format: 'js' }
      delete :cancel_friend, as: 'cancel', defaults: { format: 'js' }
      delete :delete_friend, as: 'delete', defaults: { format: 'js' }
    end
  end
  resources :user_alarms, only: [:show] do
    member do
      post :allow_friend, defaults: { format: 'js' }
      delete :reject_friend, defaults: { format: 'js' }
      delete :delete_alarm, as: 'delete', defaults: { format: 'js' }
    end
  end

  devise_for :users
end
