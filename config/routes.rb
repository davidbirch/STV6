Rails.application.routes.draw do
  resources :channels
  resources :sports
  resources :programs
  resources :regions
  resources :raw_channels
  resources :raw_programs
  root "pages#home"
  get 'about', to: 'pages#about'
  
end
