module BankAccounts
  class ValidateCreate
    def initialize(params)
      @id = params[:id]
      @name = params[:name] 
      @balance = params[:balance].try(:to_f)
      @bank_account = @id.present? ? BankAccount.where(id: @id).first : nil 
      @errors = []
    end

    def execute!
      validate_existence_of_id!
      @errors 
    end 

    private

    def validate_existence_of_id!
      if @bank_account.present?
        @errors << { 
                      message: "Id da conta já utiizado",
                      account_id: @bank_account.id,
                      account_token: @bank_account.account_token
                   }
      end   
    end   
  end 
end 