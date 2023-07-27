Rails.application.routes.draw do
  get "/" => 'tops#index'
  root to: 'tops#index'
  get 'rooms/index'
  get 'reservations/index'


#ユーザー関連
  resources :users, only: [:edit, :update]
  get 'users/account'
  get 'users/profile'
  #post 'users/profile_edit' => 'users#profile'
  #patch 'users/profile'
  get 'users/profile_edit'

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  devise_scope :user do
    get "sign_in", :to => "users/sessions#new"
    get "/users/sign_out", :to => "devise/sessions#destroy" 
  end

#施設関連
  resources :rooms do
    collection do
      get 'search' #ransackの記述
    end
  end

#予約関連
  resources :reservations
  post 'reservations/confirm'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
