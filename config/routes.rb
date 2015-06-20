Rails.application.routes.draw do
  resources :conversion_summaries, only: [:index, :show]
  resources :channels
  resources :sports
  resources :programs
  resources :regions
  resources :raw_channels
  
  resources :raw_programs
  get 'raw_programs_by_category', to: 'raw_programs#index', layout: "by_category"
  
  root "pages#home"
  get 'about', to: 'pages#about'
  
end
