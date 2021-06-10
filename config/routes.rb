Rails.application.routes.draw do
  get 'searchs' => "searchs#search"
  get "books/searchs" => "searchs#books_search"
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root :to => "homes#top"
  get "home/about" => "homes#about"

  resources :books, only: [:index, :show, :edit, :create, :destroy, :update, :order_new, :order_rate] do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
    get "new/order" => "books#new_order"
    get "rate/order" => "books#rate_order"
  end

  resources :users, only: [:index, :show, :edit, :update] do
    member do
      get :followings, :followers
    end
    resource :relationships, only: [:create, :destroy]
    get "search", to: "users#search"
  end

  resources :chats, only: [:show, :create]

  resources :groups do
      get :join
      get "new/mail" => "groups#new_mail"
      get "send/mail" => "groups#send_mail"

    end

end
