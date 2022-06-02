Rails.application.routes.draw do
  
  #users api
  post  "/users",    to: "users#create"
  get   "/users",    to: "users#index"
  patch "/users",    to: "users#update"
end
