Rails.application.routes.draw do
  root 'welcome#index'

  resources :user

  resources :user, only: [:show] do
    resources :trails, except: [:show]
  end

  resources :trails, only: [:show] do
    resources :crumbs, except: [:index]
  end


end
