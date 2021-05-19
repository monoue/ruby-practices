require_relative "make_month_year_line"
require_relative "make_days_of_week_line"
require_relative "make_dates_block"

def make_calendar(int_opts)
  month_year_line = make_month_year_line int_opts
  days_of_week_line = make_days_of_week_line
  dates_lines = make_dates_block int_opts
  "#{month_year_line}\n#{days_of_week_line}\n#{dates_lines}\n"
end
