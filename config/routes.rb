Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }
  devise_scope :user do
    get '/users', to: 'devise/registrations#new'
  end

  resources :tasks, only: %i[index new create]

  root to: 'tasks#index'
end
