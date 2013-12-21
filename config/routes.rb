Blog::Application.routes.draw do
  root to: 'splash#index'
  
  match '/search/(:query)', to: 'splash#search', via: [:get, :post], as: :search
  match '/social/login/:provider', to: 'sessions#new', via: :get, as: :social_login
  match '/auth/:provider/callback', to: 'sessions#create', via: :get
  match '/auth/failure', to: 'sessions#failure', via: :get
  match 'logout', to: 'sessions#destroy', via: :get
  match '/feed', to: 'splash#feed', via: :get, as: :feed
  
  resources :tags, only: :index
  resources :subscriptions, only: [:create, :destroy], param: :tag_id
  resources :accounts, only: [:destroy], param: :provider
  
  resources :posts do
    resources :comments
  end
  
  namespace :admin do
    root to: 'posts#index'
  
    get 'splash/login', to: 'splash#login'
    get 'splash/logout', to: 'splash#logout'
    post 'splash/authenticate', to: 'splash#authenticate'
    
    resources :posts do
      collection do
        post :approve_multiple
        post :reject_multiple
      end
      
      member do
        post :approve
        post :reject
      end
    end
    
    resources :tags, only: [:index, :edit, :update, :destroy]
    resources :references
    resources :admins, except: :show
    
  end
  
  constraints nickname: /[^\/]+/ do
    get '/:nickname/channels', to: 'profile#channels', as: :profile_channels  
    get '/:nickname/information', to: 'profile#information', as: :profile_information
    patch '/:nickname/update', to: 'profile#update', as: :profile_update
    get '/:nickname', to: 'profile#show', as: :profile
  end

  
end
