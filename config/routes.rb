Rails.application.routes.draw do
  
  resources :keywords
  resources :channel_short_names, :path => 'channels-by-short-name', only: [:index, :show]
  resources :channels
  resources :conversion_summaries, :path => '/conversion-summaries', only: [:index, :show]
  resources :program_categories, :path => '/programs-by-category', only: [:index, :show]
  resources :program_days, :path => '/programs-by-day', only: [:index, :show]
  resources :program_regions_sports, :path => '/programs-by-region-and-sport', only: [:index]
  resources :program_regions_days, :path => '/programs-by-region-and-day', only: [:index]
  resources :program_regions_channels, :path => '/programs-by-region-and-channel', only: [:index]
  resources :programs
  resources :raw_program_categories, :path => '/raw-programs-by-category', only: [:index]
  resources :raw_programs, :path => '/raw-programs', only: [:index, :show]
  resources :regions
  resources :sports
  
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: 'sessions#failure'
  get 'signout', to: 'sessions#destroy', as: 'signout'
  get 'signin', to: 'sessions#new', as: 'signin'
  get 'about', to: 'pages#about'
  root "pages#home"
  
end
