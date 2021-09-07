Rails.application.routes.draw do

  namespace :admin do
    resources :sell_items, only: [:index, :show, :update]
    resources :colors, only: [:index, :show, :destroy, :edit, :create]
    resources :categories, only: [:index, :show, :destroy, :edit, :create]
    resources :users, only: [:index, :show, :edit, :update]
    resources :items, only: [:index, :show, :destroy, :edit, :update]
  end

  devise_for :users
  devise_for :admins
    root to: 'public/homes#top'
    get 'homes/about', to: 'public/homes#about'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
