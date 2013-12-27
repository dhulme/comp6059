Src::Application.routes.draw do
  devise_for :users
  get 'pages/home'
  root 'pages#home'
  
  get 'setup_categories' => 'pages#setup_categories'
  get 'create_categories' => 'pages#setup_categories'
  
  # Templates
  resources :templates
  get 'upload' => 'templates#new'
  get 'discover' => 'templates#index'
  get 'search' => 'templates#search'
  get 'feed' => 'templates#feed', :defaults => { :format => 'atom' }
  
  # Reviews
  resources :reviews
  
  # Downloads
  resources :downloads
  
  # Categories
  resources :categories
end