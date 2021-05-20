# frozen_string_literal: true

PROGRAM_NAME = 'cal'
OPTION_FORMAT_ERR_MESSAGE = "#{PROGRAM_NAME}: illegal argument(s)"
OPTION_WITHOUT_ARG_ERR_MESSAGE = "#{PROGRAM_NAME}: option requires an argument -- m"
USAGE = "Usage: #{PROGRAM_NAME} [-m month] [-y year]"
YEAR_ONLY_ERR_MESSAGE = "#{PROGRAM_NAME}: year is not set with month"
WIDTH = 22
MONTH_MIN = 1
MONTH_MAX = 12
YEAR_MIN = 1
YEAR_MAX = 9999
DAYS_WIDTH = 15
DATES_ROW_HEIGHT = 6
COLOR_INVERSION = "\e[7m"
RESET = "\e[0m"
DAYS = %w[日 月 火 水 木 金 土].freeze
ADJUSTMENT_STR = ' ' * 3
EMPTY_DAY_STR = ' ' * 3
SATURDAY = 6
EMPTY_LINE = "\n#{' ' * 22}"
MONTH_YEAR_CENTER_STR = '月 '
