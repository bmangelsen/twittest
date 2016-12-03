Rails.application.routes.draw do

  resource :session, only: [:new, :create, :destroy]
  resources :users, only: [:index, :new, :create]
  resources :posts, except: [:show]
  resource :userprofile, only: [:show, :edit, :update] do
    member do
      get "/edit_password", action: :edit_password
      patch "/edit_password", action: :update_password
    end
  end

  root 'sessions#new'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
