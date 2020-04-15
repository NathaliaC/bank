Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post 'authenticate', to: 'authentication#authenticate'
      post 'bank_accounts/transfers', to: "bank_accounts#transfers"
      post 'bank_accounts/balances', to: "bank_accounts#balances"

      resources :bank_accounts, only: [:create]
    end
  end
end