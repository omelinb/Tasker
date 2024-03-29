Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }
  devise_scope :user do
    get '/users', to: 'devise/registrations#new'
  end

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      get 'tasks/:status', to: 'tasks#index'
    end
  end

  resources :tasks, only: %i[index show new create] do
    patch 'change_status/:event', on: :member, to: 'tasks#change_status'

    resources :approvals, only: %i[create]
  end

  root to: 'tasks#index'
end
