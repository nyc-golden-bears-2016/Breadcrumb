Rails.application.routes.draw do
  root 'welcome#index'

  resources :tags

  devise_for :users

  get '/users/:user_id/add/:id' => 'favorites#add'
  get '/users/:user_id/remove/:id' => 'favorites#remove'
  get '/users/:id' => 'users#show', :as => :user
  get '/set_coords' => 'users#set_user_coords'

  resources :trails do
    resources :crumbs, except: [:index ]
  end

  get '/trails/:id/publish' => 'trails#publish'

  resources :actives, only: [:show] do
    resources :active_crumbs, only: [:show, :update]
  end

  get '/actives/:id/join' => 'actives#join'
  post '/actives/:id/joined' => 'actives#joined'
  delete '/actives/:id' => 'actives#destroy'
  get '/actives/:id/mapdetails' => 'actives#mapdetails', :as => :active_mapdetails


end
