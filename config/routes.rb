Rails.application.routes.draw do

  #Auth endpoint
  post    '/auth',    to: 'sessions#create'
  delete  '/auth',    to: 'sessions#destroy'

  #users api
  post  "/users",    to: "users#create"
  get   "/users",    to: "users#index"
  patch "/users",    to: "users#create"


  resources :tasks
end
