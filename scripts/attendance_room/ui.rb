def welcome
  line
  puts "
  Olá, eu sou o Paulo :). Seja bem vindo(a) a Agência de matrimônios!\n
  Nesse momento, precisamos fazer uma triagem para melhor atendê-lo(a).\n
  Para isso precisamos que nos informe alguns dados."
  line
  ask_birthday
end 

def ask_birthday
  invalid_date = true
  while invalid_date
    puts "Qual a sua Data de Nascimento? Ex.: 15-02-1994" 
    answer = gets.strip
    valid_date = date_valid?(answer)
    if valid_date
      puts "Ok! Entendi, você informou #{answer}"
      return valid_date
      break
    else
      puts "Data informada é inválida!"
      if not_want_inform?
        return valid_date = nil
        break
      end
    end
  end
end

def line(qtd=70)
  puts "-" * qtd
end 

def date_valid?(date_of_birth)   
  begin
    Date.strptime(date_of_birth, '%d-%m-%Y')
  rescue ArgumentError
    return false
  end
end

def not_want_inform?
  puts "Deseja informar novamente?(S/N)"
  want_inform = gets.strip
  not_want_inform = want_inform.upcase == "N"
end