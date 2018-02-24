# == Route Map
#
#                  Prefix Verb   URI Pattern                             Controller#Action
#     password_resets_new GET    /password_resets/new(.:format)          password_resets#new
#    password_resets_edit GET    /password_resets/edit(.:format)         password_resets#edit
#            sessions_new GET    /sessions/new(.:format)                 sessions#new
#               users_new GET    /users/new(.:format)                    users#new
#                    root GET    /                                       static_pages#home
#                    help GET    /help(.:format)                         static_pages#help
#                   about GET    /about(.:format)                        static_pages#about
#                 contact GET    /contact(.:format)                      static_pages#contact
#                  signup GET    /signup(.:format)                       users#new
#                         POST   /signup(.:format)                       users#create
#                   login GET    /login(.:format)                        sessions#new
#                         POST   /login(.:format)                        sessions#create
#                  logout DELETE /logout(.:format)                       sessions#destroy
#                   users GET    /users(.:format)                        users#index
#                         POST   /users(.:format)                        users#create
#                new_user GET    /users/new(.:format)                    users#new
#               edit_user GET    /users/:id/edit(.:format)               users#edit
#                    user GET    /users/:id(.:format)                    users#show
#                         PATCH  /users/:id(.:format)                    users#update
#                         PUT    /users/:id(.:format)                    users#update
#                         DELETE /users/:id(.:format)                    users#destroy
#                my_clubs GET    /clubs/my(.:format)                     clubs#my
#                   clubs GET    /clubs(.:format)                        clubs#index
#                         POST   /clubs(.:format)                        clubs#create
#                new_club GET    /clubs/new(.:format)                    clubs#new
#               edit_club GET    /clubs/:id/edit(.:format)               clubs#edit
#                    club GET    /clubs/:id(.:format)                    clubs#show
#                         PATCH  /clubs/:id(.:format)                    clubs#update
#                         PUT    /clubs/:id(.:format)                    clubs#update
#                         DELETE /clubs/:id(.:format)                    clubs#destroy
# edit_account_activation GET    /account_activations/:id/edit(.:format) account_activations#edit
#         password_resets POST   /password_resets(.:format)              password_resets#create
#      new_password_reset GET    /password_resets/new(.:format)          password_resets#new
#     edit_password_reset GET    /password_resets/:id/edit(.:format)     password_resets#edit
#          password_reset PATCH  /password_resets/:id(.:format)          password_resets#update
#                         PUT    /password_resets/:id(.:format)          password_resets#update
# 

Rails.application.routes.draw do
  get 'password_resets/new'

  get 'password_resets/edit'

  get 'sessions/new'

  get 'users/new'

  root 'static_pages#home'
  get  '/help',    to: 'static_pages#help'
  get  '/about',   to: 'static_pages#about'
  get  '/contact', to: 'static_pages#contact'
  get  '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  resources :users
  resources :clubs do
    collection do
      get 'my' # list the clubs that I am a member
    end

    member do
      post 'join'
    end

    member do
      get 'members'
    end
  end
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
