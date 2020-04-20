#!/usr/bin/env ruby

require 'date'
require_relative 'ui'

def start
  birth_date = welcome
  if birth_date
    choose_room(birth_date)
  else
    end_service
  end
end 

def end_service
  puts "Atendimento Encerrado!"
end

def choose_room(birth_date)
  client = calculate_days(birth_date)
  young = age_days(25,2,15)
  adult = age_days(45,1,0)
  elderly = age_days(65,0,0)

  line
  if client < young
    puts "Sala 1"
  elsif client >= young && client < adult
    puts "Sala 2"
  elsif client >= adult && client < elderly
    puts "Sala 3"
  elsif client >= elderly
    puts "Sala 4"
  end
  line
  end_service
end 

def age_days(years,months,days)
  current_date = Date.today

  d = current_date.day - days
  m = current_date.month - months
  y = current_date.year - years

  birth_date = Date.strptime("#{d}-#{m}-#{y}", '%d-%m-%Y')
  calculate_days(birth_date)
end 

def calculate_days(birth_date)
  (Date.today.mjd - birth_date.mjd) + 2
end

start