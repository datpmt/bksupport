Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root 'home#index'
    get 'shopping',           to: 'shopping#index'
    get 'edit_cart',          to: 'shopping#edit_cart'
    get 'term',               to: 'home#term'
    get 'about_us',           to: 'home#about_us'
    get 'contact',            to: 'home#contact'
    get 'my_acc',             to: 'home#my_acc'
    get 'cart',               to: 'home#cart'
    get 'checkout',           to: 'home#checkout'
    get 'product_detail/:id', to: 'home#product_detail'


    get 'payment',            to: 'payment#index'
    post 'payment',           to: 'payment#create'


    get 'sitemap',            to: 'sitemap#index'

    post 'shopping',          to: 'shopping#cart'
    post 'order',             to: 'home#order'
    post 'information',       to: 'home#information'


    devise_for :customers, controllers: {
      sessions: 'customers/auths/sessions',
      registrations: 'customers/auths/registrations',
      confirmations: 'customers/auths/confirmations',
      passwords: 'customers/auths/passwords'
    }

    devise_for :administrators, controllers: {
      sessions: 'admins/auths/sessions',
      passwords: 'admins/auths/passwords'
    }
  end

  scope "(:locale)", locale: /en/, defaults: {locale: "en"} do
    devise_scope :administrator do
      get 'admin', to: 'admins/auths/sessions#new'
      get 'customers_export', to: 'admins/exports#customers_export'
      get 'admins_export', to: 'admins/exports#admins_export'
      get 'orders_export', to: 'admins/exports#orders_export'
    end

    namespace :admins, path: 'admin' do
      resources :admins
      resources :customers
      resources :products
      resources :photos
      resources :orders
    end
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
