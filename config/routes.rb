Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'sessions' }
  get 'home/index'
  root to: 'home#index'
end
