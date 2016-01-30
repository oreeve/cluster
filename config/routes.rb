Rails.application.routes.draw do
  devise_for :users

  root "landings#index"

  resources :assignments do
    resources :submissions, except: [:show]
  end

  resources :users, only: [:show]

  resources :rosters, except: [:show]
end
