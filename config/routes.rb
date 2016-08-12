Rails.application.routes.draw do
  root 'welcome#index'

  get '/users/:user_id/add/:id' => 'favorites#add'
  get '/users/:user_id/remove/:id' => 'favorites#remove'

  resources :trails do
    resources :crumbs, except: [:index, :new, :edit]
  end

  get '/trails/:id/publish' => 'trails#publish'

  get '/active/:active_id/crumb/:id' => 'active#crumb'
  get '/active/:id/join' => 'active#join'
  get '/active/:id/leave' => 'active#leave'
  get '/active/:id' => 'active#show'
  get '/active/:id/update' => 'active#update'

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
