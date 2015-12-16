Rails.application.routes.draw do

  devise_for :users, :controllers => { omniauth_callbacks: 'callbacks', registrations: 'registrations' }

  root to: 'pages#index'
  get '/secret', to: 'pages#secret', as: :secret

end
