Rails.application.routes.draw do
  # 管理者側
  namespace :admin do
    resources :reports, only: [:index, :show, :destroy]
    resources :comments, only: [:index, :destroy]
    resources :tags, only: [:index, :new, :create, :destroy]
    resources :reviews, only: [:index, :show, :destroy]
    resources :users, only: [:index, :show, :edit, :update]
  end

  # 一般ユーザー（Public側）
  scope module: :public do
    resources :reports, only: [:create]
    resources :estimates, only: [:new, :create, :show]
    resources :likes, only: [:create, :destroy, :index]
    resources :comments, only: [:create, :destroy]
    resources :reviews
    resources :users, only: [:show, :edit, :update, :index] # ← index 追加可能
    get 'homes/top', to: 'homes#top'
    get 'homes/about', to: 'homes#about'
  end

  # Devise（ユーザー認証）
  devise_for :users
  devise_scope :user do
    post 'users/guest_sign_in', to: 'public/sessions#guest_sign_in', as: :guest_sign_in
  end

  # Devise（管理者用）
    devise_for :admins, path: 'admin', controllers: {
    sessions: 'admin/sessions'
  }
  
end
