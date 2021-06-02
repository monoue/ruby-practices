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

def sort_classified_paths(paths, reverse)
  sorted_paths = paths.values.each(&:sort)
  if reverse
    sorted_paths[:files].reverse!
    sorted_paths[:files].reverse!
  end
  sorted_paths
end

def classify_paths
  paths = {files: [], directories: [], paths_not_exist: []}
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

def classify_and_sort_paths(reverse)
  paths = classify_paths
  sort_classified_paths(paths, reverse)
end

def make_noent_block(paths_not_exist)
  block = ''
  paths_not_exist.each do |path|
    block << "ls: #{path}: No such file or directory\n"
  end
  block
end

def make_files_block(files)
  block = ''

  files.each do |file|

  end
end

def main
  opt = OptionParser.new
  options = init_options(opt)
  parse_options(opt)
  return print make_dir_block('.', options, false) if ARGV.size < 1
  needs_dir_block_header = ARGV.size > 1 ? true : false
  paths = classify_and_sort_paths(options[:reverse])
  noent_block = make_noent_block(paths[:paths_not_exist])
  files_block = make_files_block(path[:files])
end

main