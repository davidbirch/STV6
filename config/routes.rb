Rails.application.routes.draw do
 
  # regular resource routes
  resources :jobs, only: [:index, :show]
  resources :cleaners
  resources :migrators
  resources :scrapers

  resources :raw_channels, :path => '/raw-channels', only: [:index, :show]
  resources :raw_programs, :path => '/raw-programs', only: [:index, :show]
  
  resources :regions do
      member do
        put 'set_black_flag_on'
        put 'set_black_flag_off'
      end
    end
  resources :sports do
      member do
        put 'set_black_flag_on'
        put 'set_black_flag_off'
      end
    end
  resources :providers
  resources :channels do
      member do
        put 'set_black_flag_on'
        put 'set_black_flag_off'
      end
    end
  resources :channel_short_names, :path => '/channels-by-short-name', only: [:index, :show]
  resources :keywords do
      member do
        put 'set_black_flag_on'
        put 'set_black_flag_off'
      end
    end

  resources :programs do
    member do
      put 'set_black_flag_on'
      put 'set_black_flag_off'
    end
  end
  
  resources :broadcast_events, :path => '/broadcast-events'
  
  resources :broadcast_services, :path => '/broadcast-services'
  resources :broadcast_service_regions, :path => '/broadcast-services-by-region', only: [:index, :show]
  resources :broadcast_service_region_and_providers, :path => '/broadcast-services-by-region-and-provider', only: [:index, :show]
  
  resources :users
    
  # special routes for sessions 
  get 'auth/:provider/callback',      to: 'sessions#create'
  get 'auth/failure',                 to: 'sessions#failure'
  get 'signout',                      to: 'sessions#destroy', as: 'signout'
  get 'signin',                       to: 'sessions#new', as: 'signin'
  
  # special routes for pages
  get 'contact',                      to: 'pages#contact'
  get 'privacy',                      to: 'pages#privacy'
  get 'dashboard',                    to: 'pages#dashboard'
  get 'home',                         to: 'pages#home'
  
  # special routes for /region and /region/sport
  get ':region_name',                 to: 'guides#show'
  get ':region_name/:sport_name',     to: 'guides#show'

  root 'guides#index'
  #root 'pages#unavailable'

end
