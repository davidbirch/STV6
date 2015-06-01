Rails.application.routes.draw do
  resources :conversion_summaries, only: [:index, :show]
  resources :channels
  resources :sports
  resources :programs
  resources :regions
  resources :raw_channels
  resources :raw_programs
  root "pages#home"
  get 'about', to: 'pages#about'
  
end
