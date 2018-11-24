Rails.application.routes.draw do
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
end
