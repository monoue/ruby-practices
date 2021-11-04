#!/usr/bin/env ruby

# frozen_string_literal: false

require_relative './option'
require_relative './grouped_filenames_container'
require_relative './long_format_block'
require_relative './normal_format_block'
require_relative './directory_block'

class Ls
  def initialize(argv: ARGV)
    @argv = argv
    @option = Option.new(argv: argv)
  end

  def put_result
    warn non_existent_paths_section
    puts body_section
  end

  def result
    non_existent_paths_section + body_section
  end

  def body_section
    files_block = if option.long_format?
                    LongFormatBlock.new(filenames: grouped_filenames_container.files,
                                        directory_path: '.')
                  else
                    NormalFormatBlock.new(grouped_filenames_container.files)
                  end
    dir_blocks = grouped_filenames_container.directories.map { |dir_path| DirectoryBlock.new(directory_path: dir_path, option: option) }
    body_blocks = files_block.text.empty? ? dir_blocks : dir_blocks.unshift(files_block)
    body_blocks.map(&:text).join("\n")
  end

  def non_existent_paths_section
    grouped_filenames_container.non_existent_paths.map { |path| "ls: #{path}: No such file or directory" }.join("\n")
  end

  private

  attr_reader :argv, :option

  def grouped_filenames_container
    GroupedFilenamesContainer.new(reverse_flag: option.reverse?, argv: option.argv)
  end
end

if __FILE__ == $PROGRAM_NAME # rubocop:disable Style/IfUnlessModifier
  Ls.new.put_result
end
