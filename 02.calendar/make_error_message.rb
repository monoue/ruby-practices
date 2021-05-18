def make_month_error_message(month_option_var)
  "cal: #{month_option_var} is not a month number (1..12)"
end

def make_year_error_message(year_option_var)
  "cal: year `#{year_option_var}' not in range 1..9999"
end
