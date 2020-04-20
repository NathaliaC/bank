class BankAccount < ApplicationRecord
  prepend SimpleCommand

  belongs_to :user
  has_many :account_transactions, dependent: :destroy

  validates :user, presence: true
  validates :name, presence: true
  validates :account_number, presence: true, uniqueness: true
  validates :balance, presence: true, numericality: true
  validates :id, uniqueness: true
  validates :account_token, uniqueness: true

  before_validation :load_defaults
  after_create :set_token
  
  def load_defaults
    if self.new_record?
      self.account_number = SecureRandom.uuid
    end
  end

  def withdraw(amount)
    self.balance -= amount.to_f
    self.save!
    register_transaction(self, amount, "withdraw")
  end 

  def deposit(amount)
    self.balance += amount.to_f
    self.save!
    register_transaction(self, amount, "deposit")
  end

  def register_transaction(account, amount, type)
    @transaction = AccountTransaction.new()
    @transaction.bank_account = account
    @transaction.amount = amount
    @transaction.transaction_type = type
    @transaction.save!
  end 

  private
    def set_token
      return if self.account_token.present?
      self.update(account_token: generate_token)
    end

    def generate_token
      JsonWebToken.encode(account_id: self.id)
    end
end
