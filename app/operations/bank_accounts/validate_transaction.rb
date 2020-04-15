module BankAccounts
  class ValidateTransaction
    def initialize(params)
      @source_account_id = params[:source_account_id].try(:to_i)
      @destination_account_id = params[:destination_account_id].try(:to_i)
      @amount = params[:amount].try(:to_f)
      @source_account = BankAccount.where(id: @source_account_id).last()
      @destination_account = BankAccount.where(id: @destination_account_id).last()
      @errors = []
    end

    def execute!
      validate_existence_of_source_account!
      validate_existence_destination_account!
      if @source_account.present? and @destination_account.present?
        validate_equal_accounts!
      end
      @errors 
    end

    private

      def validate_equal_accounts!
        if @source_account.id == @destination_account.id  
          @errors << "A conta de origem e conta de Destino não podem ser iguais."
        else
          validate_withdraw!
        end
      end 

      def validate_withdraw!
        if @amount < 0
          @errors << "Valor da Transferência deve ser maior que zero!"
        elsif @source_account.balance - @amount < 0.00 
          @errors << "A conta de origem não possui saldo suficiente."
        end
      end
    
      def validate_existence_of_source_account!
        if @source_account.blank?
          @errors << "Conta de Origem inexistente."
        end
      end 
    
      def validate_existence_destination_account!
        if @destination_account.blank?
          @errors << "Conta de Destino inexistente."
        end
      end
  end 
end 