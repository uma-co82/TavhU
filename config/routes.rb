Rails.application.routes.draw do
  devise_for :authors, controllers: {
    sessions:      'authors/sessions',
    passwords:     'authors/passwords',
    registrations: 'authors/registrations'
  }
  resources :authors, only: [:show]
  get 'author/:id/shops/:id' =>  'authors#shop_show', as: "shop_show"
  patch 'author/:id/shops/:id/reservations/:id' => 'authors#reservation_update', as: "reserve_update"
  delete 'author/:id/shops/:id/reservations/:id' => 'authors#reservation_delete', as: "reserve_delete"
  # chat
  mount ActionCable.server => '/cable'
  get 'notifications/link_through'
  devise_for :users
  root 'shops#index'
  resources :users, only: [:show, :edit, :update] do
    member do
      get :following, :followers
    end
  end
  resources :relationships, only: [:create, :destroy]
  resources :shops, only: [:new, :create, :index, :show, :destroy]
  get 'shops/fav/:id' => 'shops#fav', as: "fav_shops"
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  get 'notifications/:id/link_through', to: 'notifications#link_through',
  as: :link_through
  get 'notifications', to: 'notifications#index'
  get 'shops/:id/fav' => 'shops#shop_fav', as: "fav_user"
  get 'users/:id/matching' => 'users#match', as: "match_user"
  get 'shops/:id/reservation' => 'shops#reserve', as: "new_reservation"
  post 'shops/:id/reservation/post' => 'shops#reserve_create', as: "post_reservation"
end
