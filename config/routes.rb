Rails.application.routes.draw do
  devise_for :users
  root 'shops#index'
  resources :users, only: [:show, :edit, :update]
  resources :shops, only: [:new, :create, :index, :show]
  get 'shops/fav/:id' => 'shops#fav', as: "fav_shops"
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
