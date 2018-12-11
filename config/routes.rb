Rails.application.routes.draw do
  root 'shops#index'
  devise_for :authors, controllers: {
    sessions:      'authors/sessions',
    passwords:     'authors/passwords',
    registrations: 'authors/registrations'
  }
  resources :authors, only: [:show]
  get 'author/:id/shops/:shop_id' =>  'authors#shop_show', as: "shop_show"
  post 'shops/:id/seat/post' => 'seats#create', as: "post_seat"
  get 'shops/:id/seats' => 'seats#index', as: "seats"
  # chat
  mount ActionCable.server => '/cable'
  get 'notifications/link_through'
  devise_for :users
  resources :users, only: [:show, :edit, :update] do
    member do
      get 'rikuesuto'
      get 'quick'
      get :following, :followers
    end
  end
  resources :relationships, only: [:create, :destroy]
  resources :shops, only: [:new, :create, :index, :show, :destroy]
  post 'shops/:id/privilege/post' => "authors#privilege_create", as: "create_privilege"
  delete 'shops/:id/privilege/:privilege_id' => "authors#privilege_destroy", as: "destroy_privilege"
  get 'shops/prefecture/:id' => 'shops#index_prefecture', as: "prefecture"
  get 'shops/genre/:id' => 'shops#index_genre', as: "genre"
  get 'shops/fav/:id' => 'shops#fav', as: "fav_shops"
  get 'seats/fav/:id' => 'seats#fav', as: "fav_seats"
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  get 'notifications/:id/link_through', to: 'notifications#link_through',
  as: :link_through
  get 'notifications', to: 'notifications#index'
  get 'shops/:id/fav' => 'shops#shop_fav', as: "fav_user"
  get 'seats/:id/fav' => 'seats#seat_like', as: "like_user"
  get 'shops/:id/user/seats' => 'seats#index_user', as: "seats_user"
  get 'users/:id/matching' => 'users#match', as: "match_user"
  get 'shops/:id/user/seat/:seat_id/quick' => 'seats#seat_reserve', as: "new_quick"
  post 'shops/:id/user/seat/:seat_id/quick/post' => 'seats#seat_reserve_create', as: "post_quick"
  get 'users/:id/chat/:room_id' => 'users#chat', as: "user_chat"
  delete 'users/:id/request/destroy' => 'users#request_reject', as: "request_reject"
  patch 'users/:id/request/approval' => 'users#request_approval', as: "request_approval"
  get 'users/:id/quicks/:quick_id' => 'users#quick_show', as: "quick_show"
  get 'users/:id/requests/:request_id' => 'users#rikuesuto_show', as: "rikuesuto_show"
end
