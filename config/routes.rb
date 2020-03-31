Rails.application.routes.draw do
  devise_for :users
  resources :champions do
    resources :reviews
  end
  root 'champions#index'
  get '/search' => 'champions#search', :as => 'search_page'
end
