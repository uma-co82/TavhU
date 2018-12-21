Rails.application.routes.draw do
  # top_page
  root 'shops#index'
  # author
  devise_for :authors, controllers: {
    sessions:      'authors/sessions',
    passwords:     'authors/passwords',
    registrations: 'authors/registrations'
  }
  resources :authors, only: [:show]
  get 'author/:id/shops/:shop_id' =>  'authors#shop_show', as: "shop_show"
  # author seat
  post 'shops/:id/seat/post' => 'seats#create', as: "post_seat"
  get 'shops/:id/seats' => 'seats#index', as: "seats"
  get 'shops/:id/seats/:seat_id' => 'authors#approval_seat' , as: "approval_seat"
  # chat
  mount ActionCable.server => '/cable'
  # user
  devise_for :users
  resources :users, only: [:show, :edit, :update] do
    member do
      get 'rikuesuto'
      get 'quick'
      get 'favorite_shops'
      get :following, :followers
    end
  end
  # user follow
  resources :relationships, only: [:create, :destroy]
  # shop search
  get 'shops/search' => 'shops#search_station', as: "search_station"
  get 'shops/search/:search/genre/:id' => 'shops#search_station_genre', as: "search_station_genre"
  get 'shops/search_location' => 'shops#search_location', as: "search_location"
  get 'user_matching/shops' => 'users#search_matching_shop', as: "search_matching_shop"
  # shop
  resources :shops
  # shop review
  post 'shops/:id/review_create' => "shops#review_create", as: "shop_review_create"
  # author ßshop privilege
  post 'shops/:id/privilege/post' => "authors#privilege_create", as: "create_privilege"
  delete 'shops/:shop_id/privileges/:privilege_id' => "authors#privilege_destroy", as: "destroy_privilege"
  # shop prefecture search
  get 'shops/prefecture/:id' => 'shops#index_prefecture', as: "prefecture"
  # shop genre search
  get 'shops/genre/:id' => 'shops#index_genre', as: "genre"
  # shop fav
  get 'shops/fav/:id' => 'shops#fav', as: "fav_shops"
  # seat fav
  get 'seats/fav/:id' => 'seats#fav', as: "fav_seats"
  # author seat
  delete 'seats/:id' => 'seats#destroy', as: "seat_destroy"
  # user signout
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  # notification
  get 'notifications', to: 'notifications#index'
  # shop fav_user
  get 'shops/:id/fav' => 'shops#shop_fav', as: "fav_user"
  # seat fav_user
  get 'seats/:id/fav' => 'seats#seat_like', as: "like_user"
  # seat user
  get 'shops/:id/user/seats' => 'seats#index_user', as: "seats_user"
  # user matching
  get 'users/:id/matching' => 'users#match', as: "match_user"
  # user quick
  get 'shops/:id/user/seat/:seat_id/quick' => 'seats#seat_reserve', as: "new_quick"
  post 'shops/:id/user/seat/:seat_id/quick/post' => 'seats#seat_reserve_create', as: "post_quick"
  delete 'quick/:quick_id' => 'seats#quick_delete', as: "quick_delete"
  # chat
  get 'users/:id/chat/:room_id' => 'users#chat', as: "user_chat"
  # user quick
  delete 'users/:id/request/destroy' => 'users#request_reject', as: "request_reject"
  patch 'users/:id/request/approval' => 'users#request_approval', as: "request_approval"
  get 'users/:id/quicks/:quick_id' => 'users#quick_show', as: "quick_show"
  get 'users/:id/requests/:request_id' => 'users#rikuesuto_show', as: "rikuesuto_show"
  # user location
  post 'location/post' => 'users#create_location', as: "location_create"
  # user imasugu
  get 'imasugu/shops' => 'seats#imasugu', as: "imasugu_shops"
end
