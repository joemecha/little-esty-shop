Rails.application.routes.draw do
  get '/', to: 'application#welcome'

    # resources :merchants do
    #   resources :items, only: [:index, :show]
    #   resources :invoices, only: [:index]
    #   resources :dashboard, only: [:index]
    # end

  get '/merchants/', to: 'merchants#index', as: 'merchants_index'
  get '/merchants/:merchant_id/items', to: 'items#index', as: 'merchant_items'
  get '/merchants/:merchant_id/items/new', to: 'items#new', as: 'item_create'
  get '/merchants/:merchant_id/items/:id', to: 'items#show', as: 'merchant_item'
  post '/merchants/:merchant_id/items', to: 'items#create'
  get '/merchants/:merchant_id/items/:id/edit', to: 'items#edit', as: 'item_edit'
  patch '/merchants/:id/items', to: 'items#update', as: 'item_update'
  

  get '/merchants/:merchant_id/invoices', to: 'invoices#index', as: 'merchant_invoices'
  get '/merchants/:merchant_id/invoices/:id', to: 'invoices#show', as: 'merchant_invoice'
  get  '/merchants/:merchant_id/dashboard', to: 'dashboard#index', as: 'merchant_dashboard_index'


  namespace :admin do
    get '/', to: "dashboard#index"
    resources :merchants, only: [:index, :new, :create, :show, :edit, :update]
    resources :invoices, only: [:index, :show, :update]
  end
end
