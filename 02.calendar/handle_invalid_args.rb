require_relative 'defs'
require_relative 'is_valid_arg'
require_relative 'make_error_message'

def handle_invalid_usage(arg_opts)
  if arg_opts.key?(:year) && !arg_opts.key?(:month)
    puts YEAR_ONLY_ERROR_MESSAGE
    exit
  elsif arg_opts.key?(:month) && arg_opts[:month].nil?
    puts "#{OPTION_WITHOUT_ARGUMENT_ERROR_MESSAGE}\n#{USAGE}"
    exit
  elsif arg_opts.key?(:month) && !is_valid_month?(arg_opts[:month])
    puts(make_month_error_message arg_opts[:month])
    exit
  elsif arg_opts.key?(:year) && !is_valid_year?(arg_opts[:year])
    puts make_year_error_message arg_opts[:year]
    exit
  end
end

def handle_invalid_option_format
  if ARGV.size > 0
    puts "#{OPTION_FORMAT_ERROR_MESSAGE}\n#{USAGE}"
    exit
  end
end

def handle_invalid_args(arg_opts)
  handle_invalid_option_format
  handle_invalid_usage arg_opts
end
