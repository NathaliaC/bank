module BankAccounts
  class PerformTransaction
    def initialize(params)
      @source_account_id = params[:source_account_id].try(:to_i)
      @destination_account_id = params[:destination_account_id].try(:to_i)
      @amount = params[:amount].try(:to_f)
      @source_account = BankAccount.where(id: @source_account_id).last()
      @destination_account = BankAccount.where(id: @destination_account_id).last()
      @errors = []
    end

    def execute!
      BankAccount.transaction do
        source_sucess = @source_account.withdraw(@amount)
        destination_sucess = @destination_account.deposit(@amount)
        raise "Transaction Failed" unless source_sucess && destination_sucess

        @source_account
      end
    end
  end 
end 