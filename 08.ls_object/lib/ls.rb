#!/usr/bin/env ruby

# frozen_string_literal: false

require_relative './ls_option'
require_relative './grouped_filenames_container'
require_relative './file_status'
require_relative './sections'

class Ls
  def initialize(command_line_arguments: ARGV)
    @ls_option = LsOption.new(command_line_arguments: command_line_arguments)
    @grouped_filenames_container =
      GroupedFilenamesContainer.new(reverse_flag: ls_option.reverse?, filenames: ls_option.filenames)
  end

  def build_results
    [build_warning_message, build_result]
  end

  private

  def build_result
    file_statuses = grouped_filenames_container.files.map do |filename|
      FileStatus.new(filename: filename)
    end
    files_section = if ls_option.long_format?
                      Sections::LongFormatFilesSection.new(file_statuses)
                    else
                      Sections::NormalFormatFilesSection.new(file_statuses)
                    end
    directory_sections = grouped_filenames_container.directories.map do |directory_path|
      Sections::DirectorySection.new(directory_path: directory_path, ls_option: ls_option)
    end
    result_sections = if grouped_filenames_container.files.empty?
                        directory_sections
                      else
                        directory_sections.unshift(files_section)
                      end
    result_sections.map(&:to_s).join("\n")
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
