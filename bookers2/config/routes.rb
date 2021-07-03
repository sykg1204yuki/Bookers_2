Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#top'
  get '/home/about' => 'homes#about'

  resources :users, only: [:index, :create, :show, :edit, :update] do
    # フォロー・フォロワー機能ルーティング
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as:'followings'
    get 'followers' => 'relationships#followers', as:'followers'

  end

  resources :books do
    resource :favorites, only: [:create, :destroy]
    resources :post_comments, only: [:create, :destroy]

  end

end
