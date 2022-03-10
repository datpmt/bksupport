Rails.application.routes.draw do
  devise_for :customers
  devise_for :administrators, controllers: {
    sessions: 'admins/auths/sessions',
    passwords: 'admins/auths/passwords'
  }
  devise_scope :administrator do
    get 'admin', to: 'admins/auths/sessions#new'
    get 'customers_export', to: 'admins/exports#customers_export'
    get 'admins_export', to: 'admins/exports#admins_export'
    # get 'orders_export', to: 'admins/exports#orders_export'
  end
  namespace :admins, path: 'admin' do
    resources :admins
    resources :customers
    resources :products
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
