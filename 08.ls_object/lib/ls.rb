#!/usr/bin/env ruby

# frozen_string_literal: false

require_relative './ls_option'
require_relative './grouped_filenames_container'
require_relative './long_format_block'
require_relative './normal_format_block'
require_relative './directory_block'

class Ls
  def initialize(command_line_arguments: ARGV)
    @ls_option = LsOption.new(command_line_arguments: command_line_arguments)
    @grouped_filenames_container = GroupedFilenamesContainer.new(reverse_flag: ls_option.reverse?, argv: ls_option.filenames)
  end

  def build_results
    [build_warning_message, build_normal_result]
  end

  private

  def build_normal_result
    files_block = if ls_option.long_format?
                    LongFormatBlock.new(filenames: grouped_filenames_container.files,
                                        directory_path: '.')
                  else
                    NormalFormatBlock.new(grouped_filenames_container.files)
                  end
    dir_blocks = grouped_filenames_container.directories.map do |dir_path|
      DirectoryBlock.new(directory_path: dir_path, ls_option: ls_option)
    end
    body_blocks = files_block.text.empty? ? dir_blocks : dir_blocks.unshift(files_block)
    body_blocks.map(&:text).join("\n")
  end

  def build_warning_message
    grouped_filenames_container.non_existent_paths.map do |path|
      "ls: #{path}: No such file or directory"
    end.join("\n")
  end

  attr_reader :ls_option, :grouped_filenames_container
end

if __FILE__ == $PROGRAM_NAME # rubocop:disable Style/IfUnlessModifier
  warning_message, normal_result = Ls.new.build_results
  warn warning_message unless warning_message.empty?
  puts normal_result unless normal_result.empty?
end
