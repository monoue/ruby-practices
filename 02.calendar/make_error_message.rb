# frozen_string_literal: true

def make_month_error_message(month_option_var)
  "#{PROGRAM_NAME}: #{month_option_var} is not a month number (#{MONTH_MIN}..#{MONTH_MAX})"
end

def make_year_error_message(year_option_var)
  "#{PROGRAM_NAME}: year `#{year_option_var}' not in range #{YEAR_MIN}..#{YEAR_MAX}"
end
