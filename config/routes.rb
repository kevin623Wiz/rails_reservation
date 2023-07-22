Rails.application.routes.draw do
  get "/" => 'tops#index'
  root to: 'tops#index'
  get 'rooms/index'

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  devise_scope :user do
    get "sign_in", :to => "users/sessions#new"
    get "/users/sign_out", :to => "devise/sessions#destroy" 
  end

  resources :rooms do
    collection do
      get 'search'
    end
  end

  resources :reservations
  post 'reservations/confirm'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
