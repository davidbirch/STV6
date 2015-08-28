Rails.application.routes.draw do
  
  resources :channel_short_names, :path => '/channels-by-short-name', only: [:index, :show]
  resources :channels
  resources :keywords
  resources :migrators
  resources :program_categories, :path => '/programs-by-category', only: [:index, :show]
  resources :program_days, :path => '/programs-by-day', only: [:index, :show]
  resources :program_regions_sports, :path => '/programs-by-region-and-sport', only: [:index]
  resources :program_regions_days, :path => '/programs-by-region-and-day', only: [:index]
  resources :program_regions_channels, :path => '/programs-by-region-and-channel', only: [:index]
  resources :programs
  resources :raw_program_categories, :path => '/raw-programs-by-category', only: [:index]
  resources :raw_programs, :path => '/raw-programs', only: [:index, :show]
  resources :regions
  resources :scrapers
  resources :sports
  resources :users
  
  # special routes for sessions 
  get 'auth/:provider/callback',      to: 'sessions#create'
  get 'auth/failure',                 to: 'sessions#failure'
  get 'signout',                      to: 'sessions#destroy', as: 'signout'
  get 'signin',                       to: 'sessions#new', as: 'signin'
  
  # special routes for pages
  get 'contact',                        to: 'pages#contact'
  get 'privacy',                        to: 'pages#privacy'
    
  # special routes for /region and /region/sport
  get ':region_name',                 to: 'guides#show'
  get ':region_name/:sport_name',     to: 'guides#show'
  
  root "guides#index"
  
end
