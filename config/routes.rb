Rails.application.routes.draw do
  namespace :gateway do
    resources :transactions, only: [:create] # POST /gateway/transactions
  end

  get "/transactions/auth/:id", to: "transactions#auth" # GET /transactions/auth/:id
end
