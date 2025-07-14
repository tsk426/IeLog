Rails.application.routes.draw do
  # トップページ
  root to: 'public/homes#top'
  get 'homes/top', to: 'public/homes#top'

  # 管理者用 Devise（認証）
  devise_for :admins, path: 'admin', controllers: {
    sessions: 'admin/sessions'
  }

  # 管理者機能
  namespace :admin do
    resources :reports, only: [:index, :show, :destroy]
    resources :comments, only: [:index, :destroy]
    resources :tags, only: [:index, :new, :create, :destroy]
    resources :reviews, only: [:index, :show, :destroy]
    resources :users, only: [:index, :show, :edit, :update]
  end

 # Devise（一般ユーザー用）
devise_for :users

# ゲストログインのみ明示的に記述
devise_scope :user do
  post 'users/guest_sign_in', to: 'public/sessions#guest_sign_in', as: :guest_sign_in
end

  # 一般ユーザー機能（Public::）
  scope module: :public do
    resources :users, only: [:show, :edit, :update, :index]
    resources :reviews
    resources :comments, only: [:create, :destroy]
    resources :likes, only: [:create, :destroy, :index]
    resources :estimates, only: [:new, :create, :index, :show, :destroy]
    resources :reports, only: [:create]
    get 'guest_users/:id', to: 'guest_users#show', as: 'guest_user'
  end
end

