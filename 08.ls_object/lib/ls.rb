#!/usr/bin/env ruby

# frozen_string_literal: true

require_relative './ls_option'
require_relative './grouped_filenames_container'
require_relative './sections'

class Ls
  def initialize(command_line_arguments = ARGV)
    @ls_option = LsOption.new(command_line_arguments)
    @grouped_filenames_container =
      GroupedFilenamesContainer.new(ls_option.filenames, reverse_flag: ls_option.reverse?)
  end

  def build_results
    [build_warning_message, build_result]
  end

  private

  def build_result
    files_section =
      if ls_option.long_format?
        Sections::LongFormatFilesSection.new(grouped_filenames_container.files)
      else
        Sections::NormalFormatFilesSection.new(grouped_filenames_container.files)
      end
    directory_sections = grouped_filenames_container.directories.map do |directory_path|
      Sections::DirectorySection.new(directory_path, ls_option)
    end
    result_sections =
      if grouped_filenames_container.files.empty?
        directory_sections
      else
        [files_section, *directory_sections]
      end
    result_sections.map(&:format_section).join("\n")
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
