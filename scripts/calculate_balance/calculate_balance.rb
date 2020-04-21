#!/usr/bin/env ruby

require_relative 'config_script'

class Account
  attr_reader :id, :balance

  def initialize(id ,balance)
    @id = id
    @balance = format_currency(balance)
    @transactions = []
    add_transaction("Saldo Inicial", @balance)
  end

  def credit(amount)
    amount = amount.abs
    add_transaction("Crédito", amount)
  end

  def debit(amount)
    amount = amount.abs
    add_transaction("Débito", -amount)
  end

  def bank_fine
    amount = format_currency(300)
    add_transaction("Multa", -amount)
  end

  def add_transaction(description, amount)
    @transactions.push(description: description, amount: amount)
  end

  def balance 
    balance = 0.00
    @transactions.each do |transaction| 
      balance += transaction[:amount]
    end
    return balance
  end

  def to_s
    "ID da Conta: #{id}, Saldo: #{color(balance)}"
  end

  def self.create_accounts(files)
    accounts_file = files[0]
    transactions_file = files[1]
    accounts = []
    transactions = []
    CSV.foreach(accounts_file) do |id, balance|
      existing_account = accounts.map(&:id).include?(id)
      unless existing_account
        account = Account.new(id, balance)
        accounts.push account
        CSV.foreach(transactions_file) do |account_id, amount|
          transaction = Transaction.new(account_id, amount)
          transactions.push transaction
          if account.id == transaction.account_id
            account.execute_transaction(transaction.amount)
          end
          transactions
        end
        accounts
        account.extract
      end 
    end 
  end
  
  def execute_transaction(amount)
    if amount.positive?
      self.credit(amount)
    elsif amount.negative?
      self.debit(amount)
      if self.balance.negative?
        self.bank_fine
      end 
    end
  end 

  def color(balance)
    balance.format.colorize(balance.negative? ? :red : :green)
  end

  def extract
    puts self
    puts "Register:"
    puts "Conta Bancária: #{id}"
    puts line
    puts "Descrição".ljust(30) + "Valor".rjust(10)
    @transactions.each do |transaction|
      puts transaction[:description].ljust(30) + "#{transaction[:amount].format}".rjust(10)
    end
    puts line
    puts "Saldo:".ljust(30) + "#{color(balance)}".rjust(10)
    puts line
  end
end

class Transaction
  attr_reader :account_id, :amount

  def initialize(account_id, amount)
    @account_id = account_id
    @amount = format_currency(amount)
  end
end

def format_currency(value)
  Money.new(value, "BRL")
end 

def line(qtd=60)
  puts "-" * qtd
end 

def start
  inputted_files = ARGV  
  if ARGV.length < 2
      puts "Você não inseriu a quantidade de argumentos necessária, Esperado: 2, Informado #{ARGV.length} :("
  else
    puts "Você inseriu: :)"
    inputted_files.each do |file|
      puts file
    end
    line
    Account.create_accounts(inputted_files)
  end
end

start