require_relative 'handle_invalid_args'
require_relative 'init_arg_opts'
require_relative 'print_calender'
require 'optparse'

opt = OptionParser.new
arg_opts = init_arg_opts opt
opt.parse!(ARGV)
handle_invalid_args arg_opts
print_calender arg_opts
