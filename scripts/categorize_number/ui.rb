def welcome
  line
  puts "Olá, seja bem vindo(a) a aula de números Esotéricos, Céticos e Primos!"
  line
  ask_number
end 

def ask_number
  puts "Informe um número" 
  answer = gets.strip
  answer.to_i
end

def line(qtd=70)
  puts "-" * qtd
end