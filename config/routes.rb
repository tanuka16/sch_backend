Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  post '/login', to: "auth#create"
  post '/signup', to: "users#create"
  # post '/profile', to: "users#show"
  get '/profile', to: "users#profile"
end
# user the token to get profile info and thats a full circle of life for jwt
