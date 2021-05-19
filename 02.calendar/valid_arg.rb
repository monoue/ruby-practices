# frozen_string_literal: true

def str_is_integer?(str)
  str =~ /\A[0-9]+\z/
end

def valid_option_value?(var, min, max)
  str_is_integer?(var) && var.to_i.between?(min, max)
end

def valid_month?(var)
  valid_option_value?(var, MONTH_MIN, MONTH_MAX)
end

def valid_year?(var)
  valid_option_value?(var, YEAR_MIN, YEAR_MAX)
end
