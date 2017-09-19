Rails.application.routes.draw do
  resources :users, only: [:index, :update] do
    member do
      get 'assigned', to: 'users#assigned'
      get 'own',      to: 'users#own'
    end
    resources :tickets, only: [:index, :create] do
      put '/change_status', to: 'tickets#change_status'
    end
  end
end
