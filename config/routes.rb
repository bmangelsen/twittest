Rails.application.routes.draw do

  resource :session, only: [:new, :create, :destroy]
  resources :users, except: [:index, :destroy] do
    member do
      resources :posts, except: [:show]
    end
  end

  root 'sessions#new'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
