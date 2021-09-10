Rails.application.routes.draw do

  # 管理者routes
  namespace :admin do
    resources :sell_items, only: [:index, :show, :update]
    resources :colors,     only: [:index, :update, :destroy, :edit, :create]
    resources :categories, only: [:index, :update, :destroy, :edit, :create]
    resources :users,      only: [:index, :show, :edit, :update]
    resources :items,      only: [:index, :show, :destroy, :edit, :update]
    resources :brands,     only: [:index, :update, :destroy, :edit, :create]
  end

  # devise_routes
  devise_for :admins, controllers: {
  sessions:      'admins/sessions',
  passwords:     'admins/passwords',
  registrations: 'admins/registrations'
  }

  devise_for :users, controllers: {
  sessions:      'users/sessions',
  passwords:     'users/passwords',
  registrations: 'users/registrations'
  }
  # ユーザーroutes
  root to: 'public/homes#top'
  get      'homes/about', to: 'public/homes#about'
  get 'charts/purchase',  to: 'public/charts#purchase'
  get 'charts/disposal',  to: 'public/charts#disposal'
  get 'charts/disposal',  to: 'public/charts#index'

  resources :items, module: :public do
    #Ajaxで動くアクションのルートを作成
    collection do
      get 'get_category_children', defaults: { format: 'json' }
      get 'get_category_grandchildren', defaults: { format: 'json' }
    end
  end
  resources :users, module: :public, only: [:edit,:show,:index,:update,:unsubscribe,:withdraw]
  resources :category_managements, module: :public, only: [:new, :edit, :create, :update, :destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
