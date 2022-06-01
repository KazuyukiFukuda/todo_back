Rails.application.routes.draw do
  #Auth endpoint
  post    '/auth',    to: 'sessions#create'
  delete  '/auth',    to: 'sessions#destroy'
end
