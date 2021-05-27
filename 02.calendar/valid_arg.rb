# frozen_string_literal: true

require_relative 'make_limit'

def str_is_integer?(str)
  str =~ /\A[0-9]+\z/
end

def valid_option_value?(var, min, max)
  str_is_integer?(var) && var.to_i.between?(min, max)
end

def valid_month?(var)
  valid_option_value?(var, make_month_min, make_month_max)
end

def valid_year?(var)
  valid_option_value?(var, make_year_min, make_year_max)
end
