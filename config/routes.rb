Rails.application.routes.draw do
  devise_for :users

  root "landings#index"

  scope :users do
    resources :assignments do
      resources :submissions
    end
  end

  resources :rosters, except: [:show]
end
