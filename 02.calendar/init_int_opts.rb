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
  int_opts = {}
  int_opts[:month] = init_month arg_opts[:month]
  int_opts[:year] = init_year arg_opts[:year]
  int_opts
end
