Rails.application.routes.draw do

  #contact us page messages (form, controller, messages_tabless_Model)
  resources :messages, only: [:new, :create] # route for messages to post/get

  # TAG task for users
  resources :tasks
  # Devise for user registration & sign_in flow + OAuth
  devise_for :users, :controllers => { omniauth_callbacks: 'callbacks', registrations: 'registrations' }

  # Landing page
  root to: 'tasks#index'

  # routes for Task methods and paths to link'em
  patch '/accept_available_task', to: 'tasks#accept_available_task', as: :accept_available_task
  patch '/finished_task', to: 'tasks#finished_task', as: :finished_task
  patch '/complete_task', to: 'tasks#complete_task', as: :complete_task

  get '/my_task', to: 'tasks#my_task', as: :my_task
  get '/my_accepted_task', to: 'tasks#my_accepted_task', as: :my_accepted_task

  # Static pages & secret debug page
  get '/secret', to: 'pages#secret', as: :secret
  get '/about', to: 'pages#about', as: :about
  get '/terms_and_policy', to: 'pages#terms_and_policy', as: :terms
  get '/contact', to: 'pages#contact', as: :contact

  
end
