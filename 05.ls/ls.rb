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
  paths.values.each { |values| values.sort! }
  if reverse
    paths[:files].reverse!
    paths[:directories].reverse!
  end
  paths
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

def init_filenames(dir_name, options)
  filenames = Dir.entries(dir_name)
  filenames = filenames.reject { |filename| filename[0] == '.' } unless options[:all]
  filenames.sort!
  options[:reverse] ? filenames.reverse : filenames
end

def make_dir_blocks(directories, options, needs_dir_block_header)
  dir_blocks = []
  directories.each do |directory|
    dir_blocks << make_dir_block(init_filenames(directory, options), directory, options[:long_format], needs_dir_block_header)
  end
  dir_blocks
end

# TODO: 改変前
# def main
#   opt = OptionParser.new
#   options = init_options(opt)
#   parse_options(opt)
#   return print make_dir_block(init_filenames('.', options), '.', options[:long_format], false) if ARGV.size < 1
#   needs_dir_block_header = ARGV.size > 1 ? true : false
#   paths = classify_and_sort_paths(options[:reverse])
#   noent_block = make_noent_block(paths[:paths_not_exist])
#
#   files_block = options[:long_format] ? make_long_format_block(paths[:files]) : make_normal_dir_block(paths[:files])
#   dir_blocks = make_dir_blocks(paths[:directories], options, needs_dir_block_header)
#   body_blocks = files_block.length > 0 ? dir_blocks.unshift(files_block) : dir_blocks
#   print "#{noent_block}#{body_blocks.join("\n")}"
# end

# TODO: 改変後
def parse_and_init_options
  opt = OptionParser.new
  options = init_options(opt)
  parse_options(opt)
  options
end

# def make_result(options)
#
# end

def main
  options = parse_and_init_options
  # print make_result(options)
  return print make_dir_block(init_filenames('.', options), '.', options[:long_format], false) if ARGV.size < 1
  needs_dir_block_header = ARGV.size > 1 ? true : false
  paths = classify_and_sort_paths(options[:reverse])
  noent_block = make_noent_block(paths[:paths_not_exist])

  files_block = options[:long_format] ? make_long_format_block(paths[:files]) : make_normal_dir_block(paths[:files])
  dir_blocks = make_dir_blocks(paths[:directories], options, needs_dir_block_header)
  body_blocks = files_block.length > 0 ? dir_blocks.unshift(files_block) : dir_blocks
  print "#{noent_block}#{body_blocks.join("\n")}"
end

main