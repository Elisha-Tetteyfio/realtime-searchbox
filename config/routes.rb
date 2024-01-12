# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'search_records#index'

  post 'search', to: 'search_records#search'
  get '/suggest', to: 'search_records#suggest'
end
