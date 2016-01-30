# == Route Map
#
#      Prefix Verb   URI Pattern               Controller#Action
#       users GET    /users(.:format)          users#index
#             POST   /users(.:format)          users#create
#    new_user GET    /users/new(.:format)      users#new
#   edit_user GET    /users/:id/edit(.:format) users#edit
#        user GET    /users/:id(.:format)      users#show
#             PATCH  /users/:id(.:format)      users#update
#             PUT    /users/:id(.:format)      users#update
#             DELETE /users/:id(.:format)      users#destroy
#     session DELETE /session(.:format)        sessions#destroy
#             POST   /session(.:format)        sessions#create
# new_session GET    /session/new(.:format)    sessions#new
#

Rails.application.routes.draw do
  resources :users
  resource :session, only: [:new, :create, :destroy]
end
