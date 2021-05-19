require "date"
require_relative "defs"

def make_head_empty_str(int_opts)
  first_day = Date.new(int_opts[:year], int_opts[:month], 1).wday
  head_empty_str = ''
  first_day.times { head_empty_str << EMPTY_DAY_STR }
  head_empty_str
end

def make_tail_empty_str(int_opts)
  end_day = Date.new(int_opts[:year], int_opts[:month], -1).wday
  repeat_times = SATURDAY - end_day
  tail_empty_str = ''
  repeat_times.times { tail_empty_str << EMPTY_DAY_STR }
  "#{tail_empty_str} "
end

def make_date_str(date, today)
  if today
    sprintf "%s%2d%s", COLOR_INVERSION, date, RESET
  else
    sprintf "%2d", date
  end
end

def make_dates_str(int_opts)
  dates_str = ''
  current_height = 1
  end_date_num = Date.new(int_opts[:year], int_opts[:month], -1).day
  (1..end_date_num).each { |date_num|
    date = Date.new(int_opts[:year], int_opts[:month], date_num)
    today = (date == Date.today)
    date_str = make_date_str date_num, today
    dates_str << date_str << ' '
    if date.saturday? && date_num != end_date_num
      dates_str << " \n"
      current_height += 1
    end
  }
  return dates_str, current_height == DATES_ROW_HEIGHT
end

def make_dates_block(int_opts)
  head_empty_str = make_head_empty_str int_opts
  dates_str, dates_height_full = make_dates_str int_opts
  tail_empty_str = make_tail_empty_str int_opts
  tail_empty_str << EMPTY_LINE unless dates_height_full
  "#{head_empty_str}#{dates_str}#{tail_empty_str}"
end
