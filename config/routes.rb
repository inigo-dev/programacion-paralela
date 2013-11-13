Blog::Application.routes.draw do
  root to: 'splash#index'
  
  match '/auth/:provider/callback', to: 'sessions#create', via: :get
  match '/auth/failure', to: 'sessions#failure', via: :get
  match 'logout', to: 'sessions#destroy', via: :get
  
  resources :tags, only: :index
  
  resources :posts do
    resources :comments
  end
  
  namespace :admin do
    root to: 'posts#index'
  
    get 'splash/login', to: 'splash#login'
    get 'splash/logout', to: 'splash#logout'
    post 'splash/authenticate', to: 'splash#authenticate'
    
    resources :posts do
      member do
        post :approve
        post :reject
      end
    end
  end
  
  get '/:nickname', to: 'profile#show', as: :profile
  
end
