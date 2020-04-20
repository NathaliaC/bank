require 'csv'
require 'money'
require 'colorize'

I18n.enforce_available_locales = false
Money.rounding_mode = BigDecimal::ROUND_HALF_EVEN
Money.locale_backend = :currency