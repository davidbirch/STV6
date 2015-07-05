Rails.application.routes.draw do
  resources :conversion_summaries, :path => '/conversion-summaries', only: [:index, :show]
  resources :raw_channels, :path => '/raw-channels'
  resources :raw_programs, :path => '/raw-programs'

  resources :sports
  resources :regions
  resources :programs
  resources :channels
  
# resources :raw_program_categories
  get 'raw-programs-by-category', to: 'raw_program_categories#index'
  get 'raw-programs-by-category/:category', to: 'raw_program_categories#show'

# resources :channel_short_names
  get 'channels-by-short-name', to: 'channel_short_names#index'
  get 'channels-by-short-name/:short_name', to: 'channel_short_names#show'

# resources :program_categories
  get 'programs-by-category', to: 'program_categories#index'
  get 'programs-by-category/:url_friendly_category', to: 'program_categories#show'
 
# resources :program_days
 get 'programs-by-day', to: 'program_days#index'
 get 'programs-by-day/:day', to: 'program_days#show'
  
 
# resources :program_regions_sports
  get 'programs-by-region-and-sport', to: 'program_regions_sports#index'
  
# resources :program_regions_days
  get 'programs-by-region-and-day', to: 'program_regions_days#index'

# resources :program_regions_channels
  get 'programs-by-region-and-channel', to: 'program_regions_channels#index'

  root "pages#home"
  get 'about', to: 'pages#about'
  
end
