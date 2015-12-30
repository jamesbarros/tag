Rails.application.routes.draw do

  resources :tasks
  devise_for :users, :controllers => { omniauth_callbacks: 'callbacks', registrations: 'registrations' }
  root to: 'pages#index'

  patch '/accept_available_task', to: 'tasks#accept_available_task', as: :accept_available_task
  patch '/finished_task', to: 'tasks#finished_task', as: :finished_task
  
  get '/secret', to: 'pages#secret', as: :secret
  get '/my_task', to: 'tasks#my_task', as: :my_task

  get '/my_accepted_task', to: 'tasks#my_accepted_task', as: :my_accepted_task

end
