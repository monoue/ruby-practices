def make_month_error_message(month_option_var)
  "#{PROGRAM_NAME}: #{month_option_var} is not a month number (#{MIN_OPTION_VALUE}..#{MONTH_LIMIT})"
end

def make_year_error_message(year_option_var)
  "#{PROGRAM_NAME}: year `#{year_option_var}' not in range #{MIN_OPTION_VALUE}..#{YEAR_LIMIT}"
end
