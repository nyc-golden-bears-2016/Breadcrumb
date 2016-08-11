Rails.application.routes.draw do
  root 'welcome#index'

  resources :sessions, only: [:new, :create, :destroy]

  resources :users do
    resources :favorites, except: [:index]
  end

  resources :trails do
    resources :crumbs, except: [:index]
  end

  get 'trails/:id/publish' => 'trails#publish'

  get '/active/:active_id/crumb/:id' => 'active#crumb'
  get '/active/:id/join' => 'active#join'
  #join route will check if password is necessary & hold form to sign in
  #if no form is necessary, it will redirect
  get '/active/:id/leave' => 'active#leave'
  get '/active/:id' => 'active#show'

  get '/active/:id/update'
  #route to update user position
end
