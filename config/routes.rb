Rails.application.routes.draw do
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
end
