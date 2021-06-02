#!/usr/bin/env ruby

require_relative 'make_directory_block'
require 'optparse'


def parse_options(opt)
  begin
    opt.parse!(ARGV)
  rescue => e
    puts e.message
    exit(false)
  end
end

def init_options(opt)
  options = {}
  opt.on('-a') {options[:all] = true}
  opt.on('-l') {options[:long_format] = true}
  opt.on('-r') {options[:reverse] = true}
  options
end


def main
  opt = OptionParser.new
  options = init_options(opt)
  parse_options(opt)
  return print make_dir_block('.', options, false) if ARGV.size < 1
  needs_dir_block_header = ARGV.size > 1 ? true : false

end

main