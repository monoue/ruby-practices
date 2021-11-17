# frozen_string_literal: true

require 'optparse'

class LsOption
  attr_reader :filenames

  def initialize(command_line_arguments: ARGV)
    option_parser = OptionParser.new
    @options = init_options(option_parser)
    @filenames = option_parser.parse(command_line_arguments)
  end

  def reverse?
    options[:reverse]
  end

  def long_format?
    options[:long_format]
  end

  def all?
    options[:all]
  end

  private

  attr_reader :options

  def init_options(option_parser)
    initialized_options = {}
    option_parser.on('-a') { initialized_options[:all] = true }
    option_parser.on('-l') { initialized_options[:long_format] = true }
    option_parser.on('-r') { initialized_options[:reverse] = true }
    initialized_options
  end
end
