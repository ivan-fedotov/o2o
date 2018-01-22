Rails.application.routes.draw do

  get "profile", to: "pages#settings"
  get "settings/reload", to: "pages#reload"
  #get "settings/new_db", to: "pages#new_db"
  resources :cmd, only: [:new, :create]

  resources :tickets, param: :number do
    member do
      post 'create_message'
    end
  end
  resources :role_permissions
  get 'reports/create'
  resources :reports,  only: [:new]
  resources :roles, controller: :p_roles

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
    resource :roles, controller: 'ars' , only: [:create, :destroy]
  end
  resources :brigades
  resources :ticket_types
  resources :statuses
  resources :photos, controller: 'images'
  resources :documents
  resources :sites do
    resources :photos
  end

  root to: 'tickets#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
