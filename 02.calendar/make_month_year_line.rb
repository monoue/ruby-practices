# frozen_string_literal: true

def make_month_year_line(int_opts)
  month_year_str = format(
    '%<month_opt>d%<center_str>s%<year_opt>d',
    month_opt: int_opts[:month],
    center_str: '月 ',
    year_opt: int_opts[:year]
  )
  width = 22
  adjustment_str = ' ' * 2
  month_year_str.center(width - adjustment_str.length) + adjustment_str
end
