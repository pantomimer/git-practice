Rails.application.routes.draw do
  get 'users/show'
  get 'users/edit'

  resources :books
  devise_for :users
  root to: "homes#top"
  get 'homes/about', to: 'homes#about', as: 'about'

end
