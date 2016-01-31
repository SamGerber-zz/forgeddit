# == Route Map
#
#       Prefix Verb   URI Pattern                       Controller#Action
#        users GET    /users(.:format)                  users#index
#              POST   /users(.:format)                  users#create
#     new_user GET    /users/new(.:format)              users#new
#    edit_user GET    /users/:id/edit(.:format)         users#edit
#         user GET    /users/:id(.:format)              users#show
#              PATCH  /users/:id(.:format)              users#update
#              PUT    /users/:id(.:format)              users#update
#              DELETE /users/:id(.:format)              users#destroy
#      session POST   /session(.:format)                sessions#create
#  new_session GET    /session/new(.:format)            sessions#new
#              DELETE /session(.:format)                sessions#destroy
#    sub_posts GET    /subs/:sub_id/posts(.:format)     posts#index
#              POST   /subs/:sub_id/posts(.:format)     posts#create
# new_sub_post GET    /subs/:sub_id/posts/new(.:format) posts#new
#         subs GET    /subs(.:format)                   subs#index
#              POST   /subs(.:format)                   subs#create
#      new_sub GET    /subs/new(.:format)               subs#new
#     edit_sub GET    /subs/:id/edit(.:format)          subs#edit
#          sub GET    /subs/:id(.:format)               subs#show
#              PATCH  /subs/:id(.:format)               subs#update
#              PUT    /subs/:id(.:format)               subs#update
#              DELETE /subs/:id(.:format)               subs#destroy
#    edit_post GET    /posts/:id/edit(.:format)         posts#edit
#         post GET    /posts/:id(.:format)              posts#show
#              PATCH  /posts/:id(.:format)              posts#update
#              PUT    /posts/:id(.:format)              posts#update
#              DELETE /posts/:id(.:format)              posts#destroy
#

Rails.application.routes.draw do
  root to: "subs#index"
  resources :users
  resource :session, only: [:new, :create, :destroy]
  resources :subs
  resources :posts, except: [:index]
end
