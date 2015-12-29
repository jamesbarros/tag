Rails.application.routes.draw do

  resources :tasks
  devise_for :users, :controllers => { omniauth_callbacks: 'callbacks', registrations: 'registrations' }

  root to: 'pages#index'
  get '/secret', to: 'pages#secret', as: :secret
  get '/my_task', to: 'tasks#my_task', as: :my_task # working route, woot!

  patch '/task', to: 'tasks#accept_available_task', as: :accept_available_task # 

end
