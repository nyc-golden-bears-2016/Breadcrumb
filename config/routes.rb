Rails.application.routes.draw do
<<<<<<< 8f7df41d626ab0aadb471d1221131c72bffe9f61
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
=======
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
>>>>>>> add 'devise' gem; create USER model/migration; migrate db
end
