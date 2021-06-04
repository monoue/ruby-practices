#!/usr/bin/env ruby

# frozen_string_literal: false

require 'optparse'

module Option
  class << self
    def parse_options(opt)
      opt.parse!(ARGV)
    rescue OptionParser::InvalidOption => e
      puts e.message
      exit false
    end

    def init_option(opt)
      option = {}
      opt.on('-l') { option[:lines_only] = true }
      option
    end
  end

  private_class_method :parse_options, :init_option

  def self.parse_and_init_lines_only
    opt = OptionParser.new
    option = init_option(opt)
    parse_options(opt)
    option[:lines_only]
  end
end

module Info
  @total_lines_n = 0
  @total_words_n = 0
  @total_bytes_n = 0

  def self.make_block(num)
    format('%8d', num)
  end

  private_class_method :make_block

  def self.make_info_part_from_nums(nums)
    str = ''
    nums.each do |num|
      str << make_block(num)
    end
    str
  end

  def self.make_info_part_from_str(str, lines_only)
    lines_n = str.count("\n")
    @total_lines_n += lines_n if ARGV.size > 1
    return make_block(lines_n) if lines_only

    words_n = str.split("\s").size
    @total_lines_n += lines_n if ARGV.size > 1
    bytes_n = str.bytesize
    @total_bytes_n += bytes_n if ARGV.size > 1
    make_info_part_from_nums([lines_n, words_n, bytes_n])
  end
end

module Arg
  class << self
    def make_error_message_line(arg, error_message)
      format("wc :%<arg>s: open: %<err_msg>s\n", arg: arg, err_msg: error_message)
    end

    def make_line_from_arg(arg, lines_only)
      File.open(arg) { |file| "#{Info.make_info_part_from_str(file.read, lines_only)} #{arg}\n" }
    rescue Errno::ENOENT, Errno::EACCES => e
      make_error_message_line(arg, e.class.new)
    end

    def make_total_line(lines_only)
      nums = lines_only ? [@total_lines_n] : [@total_lines_n, @total_words_n, @total_bytes_n]
      "#{Info.make_info_part_from_nums nums} total\n"
    end
  end

  private_class_method :make_error_message_line, :make_line_from_arg, :make_total_line

  def self.make_result_from_argv(lines_only)
    str = ''
    ARGV.each do |arg|
      str << make_line_from_arg(arg, lines_only)
    end
    str << make_total_line(lines_only) if ARGV.size > 1
    str
  end
end

def make_result_from_stdin(lines_only)
  "#{Info.make_info_part_from_str($stdin.read, lines_only)}\n"
end

def main
  lines_only = Option.parse_and_init_lines_only
  result = ARGV.empty? ? make_result_from_stdin(lines_only) : Arg.make_result_from_argv(lines_only)
  print result
end

main
