Rails.application.routes.draw do

  root to: 'home#index'

  #ログイン機能
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  #ユーザCRUD機能
  get '/register', to: 'users#new'
  post '/register', to: 'users#create'

  get '/users/account', to: 'users#show_account'
  get '/users/edit', to: 'users#edit_account'
  patch '/users/edit', to: 'users#update_account'

  get '/users/profile', to: 'users#edit_profile'
  patch '/users/profile', to: 'users#update_profile'

  #ルームCRUD機能
  resources :rooms, except: [:show, :destroy, :edit] do
  #検索機能
    collection do
      get 'search'
    end
  end

  #予約機能
  resources :bookings, only: [:index, :show, :new, :create] do
    post :confirm, action: :confirm_new, on: :new
  end
end
