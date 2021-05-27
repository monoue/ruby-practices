# frozen_string_literal: true

require_relative 'make_limit'
require_relative 'make_program_name'

def make_month_error_message(month_option_var)
  "#{make_program_name}: #{month_option_var} is not a month number (#{make_month_min}..#{make_month_max})"
end

def make_year_error_message(year_option_var)
  "#{make_program_name}: year `#{year_option_var}' not in range #{make_year_min}..#{make_year_max}"
end
