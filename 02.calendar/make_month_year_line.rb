# frozen_string_literal: true

require_relative 'defs'

def calc_longer_half_integer(len)
  (len.to_f / 2).ceil
end

def calc_head_empty_width(month_year_len)
  left_space_len = WIDTH - (month_year_len + MONTH_YEAR_CENTER_STR.length + ADJUSTMENT_STR.length)
  calc_longer_half_integer(left_space_len)
end

def make_month_year_line(int_opts)
  month_year_len = int_opts.values.map { |n| n.to_s.length }.sum
  head_empty_width = calc_head_empty_width(month_year_len)
  month_year_str = format(
    '%<month_opt>d%<center_str>s%<year_opt>d',
    month_opt: int_opts[:month],
    center_str: MONTH_YEAR_CENTER_STR,
    year_opt: int_opts[:year]
  )
  format '%-*s', WIDTH, (' ' * head_empty_width) << month_year_str
end
