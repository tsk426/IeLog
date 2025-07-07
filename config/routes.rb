Rails.application.routes.draw do
  namespace :admin do
    get 'reports/index'
    get 'reports/show'
    get 'reports/destroy'
  end
  namespace :admin do
    get 'comments/index'
    get 'comments/destroy'
  end
  namespace :admin do
    get 'tags/index'
    get 'tags/new'
    get 'tags/create'
    get 'tags/destroy'
  end
  namespace :admin do
    get 'reviews/index'
    get 'reviews/show'
    get 'reviews/destroy'
  end
  namespace :admin do
    get 'users/index'
    get 'users/show'
    get 'users/edit'
    get 'users/update'
  end
  namespace :admin do
    get 'sessions/new'
    get 'sessions/create'
    get 'sessions/destroy'
  end
  scope module: :public do
    get 'reports/create'
  end
  scope module: :public do
    get 'estimates/new'
    get 'estimates/create'
    get 'estimates/show'
  end
  scope module: :public do
    get 'likes/create'
    get 'likes/destroy'
    get 'likes/index'
  end
  scope module: :public do
    get 'comments/create'
    get 'comments/destroy'
  end
  scope module: :public do
    get 'reviews/index'
    get 'reviews/show'
    get 'reviews/new'
    get 'reviews/create'
    get 'reviews/edit'
    get 'reviews/update'
    get 'reviews/destroy'
  end
  scope module: :public do
    get 'users/show'
    get 'users/edit'
    get 'users/update'
  end
  scope module: :public do
    get 'homes/top'
    get 'homes/about'
  end
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
