require_relative "defs"

def calc_longer_half_integer(len)
  (len.to_f / 2).ceil
end

def calc_head_empty_width(month_year_len)
  left_space_len = WIDTH - (month_year_len + MONTH_YEAR_CENTER_STR.length)
  calc_longer_half_integer(left_space_len)
end

def make_month_year_line(int_opts)
  month_year_len = int_opts.values.map { |n| n.to_s.length }.sum
  head_empty_width = calc_head_empty_width(month_year_len)
  month_year_str = sprintf "%d%s%d", int_opts[:month], MONTH_YEAR_CENTER_STR, int_opts[:year]
  sprintf "%-*s", WIDTH, (' ' * head_empty_width) << month_year_str
end
