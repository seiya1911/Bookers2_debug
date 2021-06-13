# frozen_string_literal: true

Rails.application.routes.draw do
  get 'searchs' => 'searchs#search'
  get 'books/searchs' => 'searchs#books_search'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'homes#top'
  get 'home/about' => 'homes#about'

  resources :books, only: %i[index show edit create destroy update order_new order_rate] do
    resource :favorites, only: %i[create destroy]
    resources :book_comments, only: %i[create destroy]
    get 'new/order' => 'books#new_order'
    get 'rate/order' => 'books#rate_order'
  end

  resources :users, only: %i[index show edit update] do
    member do
      get :followings, params: :followers
    end
    resource :relationships, only: %i[create destroy]
    get 'search', params: { to: 'users#search' }
  end

  resources :chats, only: %i[show create]

  resources :groups do
    get :join
    get 'new/mail' => 'groups#new_mail'
    get 'send/mail' => 'groups#send_mail'
  end
end
