module Api::V1
  class BankAccountsController < Api::V1::ApiController
    skip_before_action :authenticate_request, except: [ :create ]
    before_action :authenticate_account, except: [ :create ]

    attr_reader :current_account

    def create
      errors = ::BankAccounts::ValidateCreate.new(account_params).execute!
      if errors.size > 0
        render json: { errors: errors }, status: :unprocessable_entity
      else
        bank_account = BankAccount.new(account_params)
        bank_account.user = current_user
        if bank_account.save
          render json: bank_account, status: :created
        else
            render json: bank_account.errors, status: :unprocessable_entity
        end
      end
    end

    def transfers
      errors = ::BankAccounts::ValidateTransaction.new(params_transfers).execute!
      if errors.size > 0
        render json: { errors: errors }, status: :unprocessable_entity
      else
        bank_account = ::BankAccounts::PerformTransaction.new(params_transfers).execute!
        render json: { source_account: { id: bank_account.id, balance: bank_account.balance} }
      end
    end   

    def balances
      errors = ::BankAccounts::ValidateBalance.new(params_balances).execute!
      if errors.size > 0
        render json: { errors: errors }, status: :unprocessable_entity
      else
        bank_account = BankAccount.where(id: params_balances[:account_id]).last()
        render json: { bank_account: { id: bank_account.id, balance: bank_account.balance} }
      end
    end

    private

      def account_params
        params.permit(:id, :name, :balance)
      end

      def params_transfers
        params.permit(:source_account_id, :destination_account_id, :amount)
      end 

      def params_balances
        params.permit(:account_id)
      end

      def authenticate_account
        @current_account = AuthorizeBankAccountRequest.call(request.headers).result
        render json: { error: 'Not Authorized' }, status: 401 unless @current_account
      end
  end
end
