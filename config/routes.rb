Rails.application.routes.draw do
  #Get me
  get     '/me',      to: 'mes#index'

  #Auth endpoint
  post    '/auth',    to: 'sessions#create'
  delete  '/auth',    to: 'sessions#destroy'

  #users api

  #post  "/users",    to: "users#create"
  #get   "/users",    to: "users#index"
  #patch "/users",    to: "users#create"


  resources :tasks

  #patch "/users/:id",  to: "users#update"
  resources :users

  

end
