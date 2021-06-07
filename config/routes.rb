Rails.application.routes.draw do
  get 'searchs' => "searchs#search"
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root :to => "homes#top"
  get "home/about" => "homes#about"

  resources :books, only: [:index, :show, :edit, :create, :destroy, :update] do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
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
    member do
      get :join
    end
  end

end
