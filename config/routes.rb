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
  get 'raw_program_categories/:category', to: 'raw_program_categories#show'
  
  root "pages#home"
  get 'about', to: 'pages#about'
  
end
