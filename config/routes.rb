Rails.application.routes.draw do
  resources :raw_channels
  resources :raw_programs
  root "pages#home"
  get 'about', to: 'pages#about'
  
end
