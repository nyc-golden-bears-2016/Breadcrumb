Rails.application.routes.draw do
  root 'welcome#index'

  devise_for :users

  get '/users/:user_id/add/:id' => 'favorites#add'
  get '/users/:user_id/remove/:id' => 'favorites#remove'
  get '/users/:id' => 'users#show', :as => :user

  resources :trails do
    resources :crumbs, except: [:index ]
  end

  get '/trails/:id/publish' => 'trails#publish'

  get '/actives/:id/join' => 'actives#join'
  post '/actives/:id/joined' => 'actives#joined'
  post '/actives/:active_id/crumb/:id' => 'actives#answered'
  get '/actives/:id/leave' => 'actives#leave'
  get '/actives/:id' => 'actives#show'
  get '/actives/:id/update' => 'actives#update'
  delete '/actives/:id' => 'actives#destroy'

end
