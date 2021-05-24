# frozen_string_literal: true

require 'date'

def init_month(month)
  if month.nil?
    Date.today.month
  else
    month.to_i
  end
end

def init_year(year)
  if year.nil?
    Date.today.year
  else
    year.to_i
  end
end

def init_int_opts(arg_opts)
  { month: init_month(arg_opts[:month]), year: init_year(arg_opts[:year]) }
end
