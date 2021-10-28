#!/usr/bin/env ruby

# frozen_string_literal: false

require 'optparse'

class Option
  def initialize
    @options = parse_and_init_options
  end

  def reverse?
    options[:reverse] == true
  end

  def long_format?
    options[:long_format] == true
  end

  def all?
    options[:all] == true
  end

  private

  def parse_and_init_options
    opt = OptionParser.new
    options = init_options(opt)
    parse_options(opt)
    options
  end

  def init_options(opt)
    options = {}
    opt.on('-a') { options[:all] = true }
    opt.on('-l') { options[:long_format] = true }
    opt.on('-r') { options[:reverse] = true }
    options
  end

  def parse_options(opt)
    opt.parse!(ARGV)
  rescue OptionParser::InvalidOption => e
    puts e.message
    exit(false)
  end

  attr_reader :options
end
