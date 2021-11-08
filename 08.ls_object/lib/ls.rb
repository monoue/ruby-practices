#!/usr/bin/env ruby

# frozen_string_literal: false

require_relative './ls_option'
require_relative './grouped_filenames_container'
require_relative './long_format_files_section'
require_relative './normal_format_files_section'
require_relative './directory_block'

class Ls
  def initialize(command_line_arguments: ARGV)
    @ls_option = LsOption.new(command_line_arguments: command_line_arguments)
    @grouped_filenames_container = GroupedFilenamesContainer.new(reverse_flag: ls_option.reverse?, filenames: ls_option.filenames)
  end

  def build_results
    [build_warning_message, build_normal_result]
  end

  private

  def build_normal_result
    files_section = if ls_option.long_format?
                    LongFormatFilesSection.new(filenames: grouped_filenames_container.files,
                                               directory_path: '.')
                  else
                    NormalFormatFilesSection.new(grouped_filenames_container.files)
                  end
    dir_blocks = grouped_filenames_container.directories.map do |dir_path|
      DirectoryBlock.new(directory_path: dir_path, ls_option: ls_option)
    end
    body_blocks = files_section.to_s.empty? ? dir_blocks : dir_blocks.unshift(files_section)
    body_blocks.map(&:to_s).join("\n")
  end

  def build_warning_message
    grouped_filenames_container.non_existent_paths.map do |path|
      "ls: #{path}: No such file or directory"
    end.join("\n")
  end

  attr_reader :ls_option, :grouped_filenames_container
end

if __FILE__ == $PROGRAM_NAME
  warning_message, normal_result = Ls.new.build_results
  warn warning_message unless warning_message.empty?
  puts normal_result unless normal_result.empty?
end
