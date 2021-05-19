require_relative "defs"

def make_days_of_week_line
  days_str = DAYS.join(' ')
  sprintf "%-*s", DAYS_WIDTH, days_str
end
