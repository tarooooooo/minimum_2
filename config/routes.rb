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

  get 'sell_items/:id/order_new', to: 'public/sell_items#order_new', as: 'sell_items_order_new'
  get 'sell_items/:id/order_confirm', to: 'public/sell_items#order_confirm', as: 'sell_items_order_confirm'
  patch 'sell_items/:id/order_finish', to: 'public/sell_items#order_finish', as: 'sell_items_order_finish'
  get 'sell_items/:id/order_complete', to: 'public/sell_items#order_complete', as: 'sell_items_order_complete'
  get 'sell_items/:id/order_rate', to: 'public/sell_items#order_rate', as: 'sell_items_order_rate'
  patch 'sell_items/:id/order_rate_update', to: 'public/sell_items#order_rate_update', as: 'order_rate_update'
  patch 'sell_items/:id/order_status_update', to: 'public/sell_items#order_status_update', as: 'order_status_update'
  get 'sell_items/myitems_by_sell', to: 'public/sell_items#myitems_by_sell', as: 'myitems_by_sell'
  get 'sell_items/myitems_by_order', to: 'public/sell_items#myitems_by_order', as: 'myitems_by_order'
  get 'sell_items/myitems_by_order_status', to: 'public/sell_items#myitems_by_order_status', as: 'myitems_by_order_status'
  resources :sell_items, module: :public do
    resource :likes, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
    collection do
      get 'search'
    end
    # get :order_new, on: :member
    # collection do
    #   put 'order_confirm'
    #   get 'order_complete'
    # end
  end
  get 'items/item_status_change', to: 'public/items#item_status_change', as: 'item_status_change'
  resources :items, module: :public do
    get 'sell_item/new', to: 'sell_items#new'
    #Ajaxで動くアクションのルートを作成
    collection do
      get 'get_category_children', defaults: { format: 'json' }
      get 'get_category_grandchildren', defaults: { format: 'json' }
    end
  end
  resources :users, module: :public, only: [:edit,:show,:index,:update,:unsubscribe,:withdraw] do
    member do
      get :rate
    end
  end
  resources :category_managements, module: :public, only: [:new, :edit, :create, :update, :destroy]
  resources :notifications, module: :public, only: [:index, :destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
