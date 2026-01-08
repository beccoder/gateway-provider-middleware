Rails.application.routes.draw do
  namespace :gateway do
    resources :transactions, only: [:create]
  end

  get "/transactions/auth/:id", to: "transactions#auth"
end
