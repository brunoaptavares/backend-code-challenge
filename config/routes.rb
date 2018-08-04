Rails.application.routes.draw do
  post '/distance', to: 'distance#create'
  get  '/cost',     to: 'shipping#show'
end
