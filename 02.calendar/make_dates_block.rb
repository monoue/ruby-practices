# frozen_string_literal: false

require 'date'

EMPTY_DAY_STR = ' ' * 3

def make_head_empty_str(int_opts)
  EMPTY_DAY_STR * Date.new(int_opts[:year], int_opts[:month], 1).wday
end

def make_tail_empty_str(int_opts)
  saturday = 6
  "#{EMPTY_DAY_STR * (saturday - Date.new(int_opts[:year], int_opts[:month], -1).wday)} "
end

def make_date_str(date)
  if date == Date.today
    color_inversion = "\e[7m"
    reset = "\e[0m"
    format '%<color>s%<date_num>2d%<reset>s', color: color_inversion, date_num: date.day, reset: reset
  else
    format '%2d', date.day
  end
end

def make_dates_str(int_opts)
  dates_str = ''
  current_height = 1
  end_date_num = Date.new(int_opts[:year], int_opts[:month], -1).day
  (1..end_date_num).each do |date_num|
    date = Date.new(int_opts[:year], int_opts[:month], date_num)
    date_str = make_date_str(date)
    dates_str << "#{date_str} "
    if date.saturday? && date_num != end_date_num
      dates_str << " \n"
      current_height += 1
    end
  end
  [dates_str, current_height]
end

def make_dates_block(int_opts)
  head_empty_str = make_head_empty_str int_opts
  dates_str, dates_str_height = make_dates_str int_opts
  tail_empty_str = make_tail_empty_str int_opts
  empty_line = "\n#{' ' * 22}"
  dates_rows_height = 6
  tail_empty_str << empty_line unless dates_str_height == dates_rows_height
  "#{head_empty_str}#{dates_str}#{tail_empty_str}"
end
