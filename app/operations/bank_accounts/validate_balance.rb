module BankAccounts
  class ValidateBalance
    def initialize(param)
      @account_id = param[:account_id]
      @bank_account = @account_id.present? ? BankAccount.where(id: @account_id).first : nil 
      @errors = []
    end

    def execute!
      validate_existence_of_account!
      @errors 
    end 

    private

    def validate_existence_of_account!
      if @bank_account.blank?
        @errors << { message: "Conta Inexistente!" }
      end   
    end
  end 
end 