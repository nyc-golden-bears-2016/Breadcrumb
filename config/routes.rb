Rails.application.routes.draw do
  root 'welcome#index'


  get '/users/:user_id/add/:id' => 'favorites#add'
  get '/users/:user_id/remove/:id' => 'favorites#remove'

  resources :trails do
    resources :crumbs, except: [:index ]
  end

  get '/trails/:id/publish' => 'trails#publish'

  get '/actives/:active_id/crumb/:id' => 'actives#crumb'
  get '/actives/:id/join' => 'actives#join'
  post '/actives/:id/joined' => 'actives#joined'
  get '/actives/:id/leave' => 'actives#leave'
  get '/actives/:id' => 'actives#show'
  get '/actives/:id/update' => 'actives#update'

  devise_for :users

  get '/users/:id' => 'users#show', :as => :user
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
