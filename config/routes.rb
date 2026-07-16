Rails.application.routes.draw do
  get "sign_ups/show"
  root "home#index"
  resource :session
  resources :passwords, param: :token
  resource :sign_up, only: %i[show create]
  resources :projects do
    resources :tasks do
      patch :toggle, on: :member
    end
  end
end
