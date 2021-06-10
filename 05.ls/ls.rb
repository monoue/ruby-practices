#!/usr/bin/env ruby

# frozen_string_literal: false

require_relative 'make_directory_blocks'
require 'optparse'

module Option
  class << self
    def parse_options(opt)
      opt.parse!(ARGV)
    rescue OptionParser::InvalidOption => e
      puts e.message
      exit(false)
    end

    def init_options(opt)
      options = {}
      opt.on('-a') { options[:all] = true }
      opt.on('-l') { options[:long_format] = true }
      opt.on('-r') { options[:reverse] = true }
      options
    end
  end

  private_class_method :parse_options, :init_options

  def self.parse_and_init_options
    opt = OptionParser.new
    options = init_options(opt)
    parse_options(opt)
    options
  end
end

module ClassifyAndSort
  class << self
    def sort_classified_paths(paths, reverse)
      paths.each_value(&:sort!)
      if reverse
        paths[:files].reverse!
        paths[:directories].reverse!
      end
      paths
    end

    def classify_paths
      paths = { files: [], directories: [], paths_not_exist: [] }
      ARGV.each do |path|
        if File.file?(path)
          paths[:files] << path
        elsif File.directory?(path)
          paths[:directories] << path
        else
          paths[:paths_not_exist] << path
        end
      end
      paths
    end
  end

  private_class_method :sort_classified_paths, :classify_paths

  def self.classify_and_sort_paths(reverse)
    paths = classify_paths
    sort_classified_paths(paths, reverse)
  end
end

def make_noent_block(paths_not_exist)
  block = ''
  paths_not_exist.each do |path|
    block << "ls: #{path}: No such file or directory\n"
  end
  block
end

def make_body_blocks(paths, options)
  files_block = options[:long_format] ? LongFormat.make_long_format_block(paths[:files], '.') : NormalFormat.make_normal_dir_block(paths[:files])
  dir_blocks = DirBlock.make_dir_blocks(paths[:directories], options)
  files_block.length.positive? ? dir_blocks.unshift(files_block) : dir_blocks
end

def make_result(options)
  return DirBlock.make_dir_block('.', options) if ARGV.empty?

  paths = ClassifyAndSort.classify_and_sort_paths(options[:reverse])
  noent_block = make_noent_block(paths[:paths_not_exist])
  body_blocks = make_body_blocks(paths, options)
  "#{noent_block}#{body_blocks.join("\n")}"
end

def main
  options = Option.parse_and_init_options
  print make_result(options)
end

main
