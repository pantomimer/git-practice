Rails.application.routes.draw do
  resources :users, only: [:show, :edit, :update]
  resources :books
  devise_for :users
  root to: "homes#top"
  get 'homes/about', to: 'homes#about', as: 'about'

end
