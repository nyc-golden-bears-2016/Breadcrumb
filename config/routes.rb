Rails.application.routes.draw do
  root 'welcome#index'

  devise_for :users

  get '/users/:user_id/add/:id' => 'favorites#add'
  get '/users/:user_id/remove/:id' => 'favorites#remove'

  resources :trails do
    resources :crumbs, except: [:index, :show ]
  end

  get '/trails/:id/publish' => 'trails#publish'

  get '/actives/:active_id/crumb/:id' => 'actives#crumb'
  get '/actives/:id/join' => 'actives#join'
  post '/actives/:id/joined' => 'actives#joined'
  get '/actives/:id/leave' => 'actives#leave'
  get '/actives/:id' => 'actives#show'
  get '/actives/:id/update' => 'actives#update'
  delete '/actives/:id' => 'actives#destroy'

  get '/users/:id' => 'users#show', :as => :user

end
