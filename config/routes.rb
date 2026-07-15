Rails.application.routes.draw do
  get "sign_ups/show"
  resource :session
  resources :passwords, param: :token
  resource :sign_up, only: %i[show create]
  root "home#index"
end
