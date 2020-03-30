Rails.application.routes.draw do
  devise_for :users
  resources :champions do
    resources :reviews
  end
  root 'champions#index'
end
