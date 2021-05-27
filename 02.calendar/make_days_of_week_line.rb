# frozen_string_literal: true

def make_days_of_week_line
  days_line_width = 15
  format '%-*s', days_line_width, '日 月 火 水 木 金 土'
end
