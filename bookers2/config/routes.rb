Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#top'
  get 'about' => 'homes#about'
  resources :books
  resources :users, only: [:index, :show, :edit, :update]



end
