# frozen_string_literal: true

require_relative 'defs'

def make_days_of_week_line
  days_str = DAYS.join(' ')
  format '%-*s', DAYS_WIDTH, days_str
end
