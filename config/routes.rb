Rails.application.routes.draw do

  get 'reports/create'
  resources :reports,  only: [:new]

  get 'photo_reports/create'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy'

  devise_for :users, controllers: { sessions: 'users/sessions' }
  resources :jobs
  resources :prices
  resources :accounts do
    resource :password, only: [:new, :update] do
      member do
        get :switch
      end
    end
  end
  resources :brigades
  resources :ticket_types
  resources :statuses
  resources :photos, controller: 'images'
  resources :documents
  resources :sites do
    resources :photos
  end
  resources :tickets do
    member do
      post 'create_message'
    end
  end

  get "settings", to: "pages#settings"
  get "settings/reload", to: "pages#reload"

  root to: 'tickets#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
