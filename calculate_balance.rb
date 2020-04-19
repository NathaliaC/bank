#!/usr/bin/env ruby

load 'config_script.rb'

class BankAccount
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

  def format_currency(value)
    Money.new(value, "BRL")
  end 

  def map_transactions(transaction_file)
    transactions = {}
    CSV.foreach(transaction_file) do |account_id, amount|
      amount = format_currency(amount)
      if transactions.include?(account_id)
        transactions[account_id].push amount
      else 
        transactions[account_id] = [amount]
      end
    end
    return transactions
  end 

  def to_s
    "ID da Conta: #{id}, Saldo: #{color(balance)}"
  end
  
  def generate_transaction(transaction_file)
    transactions = map_transactions(transaction_file) 
    
    if transactions.include?(self.id)
      transactions[self.id].map do |amount|
        if amount.positive?
          self.credit(amount)
        elsif amount.negative?
          self.debit(amount)
          if self.balance.negative?
            self.bank_fine
          end 
        end
      end
    end
  end 

  def self.create_accounts(files)
    accounts_file = files[0]
    transaction_file = files[1]

    CSV.foreach(accounts_file) do |account_id, balance|
      bank_account = BankAccount.new(account_id, balance)
      bank_account.generate_transaction(transaction_file)
      bank_account.extract
    end
  end 

  def color(balance)
    if balance.negative?
      balance.format.colorize(:red)
    else
      balance.format.colorize(:green)
    end
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

def line(qtd=60)
  puts "-" * qtd
end 

def validate_arguments
  inputted_files = ARGV  
  if ARGV.length < 2
      puts "Você não inseriu a quantidade de argumentos necessária, Esperado: 2, Informado #{ARGV.length} :("
  else
    puts "Você inseriu: :)"
    inputted_files.each do |file|
      puts file
    end
    line
    generate_balance(inputted_files)
  end
end

def generate_balance(files)
  BankAccount.create_accounts(files)
end 

def start_program
  validate_arguments
end 

start_program
