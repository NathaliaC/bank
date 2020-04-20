#!/usr/bin/env ruby

require_relative 'ui'
require 'prime'

def esoteric(number)
  number % 3 == 0 && number % 5 == 0
end 

def start
  number = welcome
  if esoteric(number)
    puts "Número é Esotérico"
  elsif Prime.prime?(number)
    puts "Número Primo"
  else
    puts "Número Cético"
  end
  program_end
end 

def program_end
  puts "Programa Encerrado!"
end

start