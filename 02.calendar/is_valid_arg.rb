def str_is_integer?(str)
  str =~ /\A[0-9]+\z/
end

def is_valid_option_value?(var, limit)
  str_is_integer?(var) && var.to_i.between?(MIN_OPTION_VALUE, limit)
end

def is_valid_month?(var)
  is_valid_option_value?(var, MONTH_LIMIT)
end

def is_valid_year?(var)
  is_valid_option_value?(var, YEAR_LIMIT)
end
