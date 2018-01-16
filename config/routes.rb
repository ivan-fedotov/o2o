Rails.application.routes.draw do
  get 'reports/create'
  resources :reports,  only: [:new]

  get 'photo_reports/create'

  devise_for :users, controllers: { sessions: 'users/sessions' }
  resources :jobs
  resources :prices
  resources :accounts
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

  root to: 'tickets#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
