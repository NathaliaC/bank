require 'bundler/inline'
require 'csv'
require 'securerandom'
require 'optparse'

gemfile do
  source 'https://rubygems.org'
  gem 'money', '~> 6.13', '>= 6.13.7'
  gem 'colorize'
end

require 'money'
require 'colorize'

I18n.enforce_available_locales = false
Money.rounding_mode = BigDecimal::ROUND_HALF_EVEN
Money.locale_backend = :currency