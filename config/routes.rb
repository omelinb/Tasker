Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }
  devise_scope :user do
    get '/users', to: 'devise/registrations#new'
  end

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :tasks, only: %i[index]
    end
  end

  resources :tasks, only: %i[index show new create] do
    resources :approvals, only: %i[create]
  end

  root to: 'tasks#index'
end
