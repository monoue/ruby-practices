#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'handle_invalid_args'
require_relative 'init_arg_opts'
require_relative 'init_int_opts'
require_relative 'make_calendar'
require 'optparse'

opt = OptionParser.new
arg_opts = init_arg_opts opt
opt.parse!(ARGV)
handle_invalid_args arg_opts
int_opts = init_int_opts arg_opts
calendar = make_calendar int_opts
print calendar
