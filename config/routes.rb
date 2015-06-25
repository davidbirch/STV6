Rails.application.routes.draw do
  resources :conversion_summaries, only: [:index, :show]
  resources :channels
  resources :sports
  resources :programs
  resources :regions
  resources :raw_channels
  
  resources :raw_programs
  
# resources :raw_program_categories
  get 'raw_programs_by_category', to: 'raw_program_categories#index'
  get 'raw_programs_by_category/:category', to: 'raw_program_categories#show'

# resources :channel_short_names
  get 'channels_by_short_name', to: 'channel_short_names#index'
  get 'channels_by_short_name/:short_name', to: 'channel_short_names#show'

  root "pages#home"
  get 'about', to: 'pages#about'
  
end
