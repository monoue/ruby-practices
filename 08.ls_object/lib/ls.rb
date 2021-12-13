#!/usr/bin/env ruby

# frozen_string_literal: true

require_relative './ls_option'
require_relative './sections'

class Ls
  def initialize(command_line_arguments = ARGV)
    @ls_option = LsOption.new(command_line_arguments)
    @files, @directories, @non_existent_paths = group_paths(@ls_option.filenames, @ls_option.reverse?)
  end

  def build_results
    [build_warning_message, build_result]
  end

  private

  attr_reader :ls_option, :files, :directories, :non_existent_paths

  def build_result
    files_section =
      if ls_option.long_format?
        Sections::LongFormatFilesSection.new(files)
      else
        Sections::NormalFormatFilesSection.new(files)
      end
    directory_sections = directories.map do |directory_path|
      Sections::DirectorySection.new(directory_path, ls_option)
    end
    result_sections =
      if files.empty?
        directory_sections
      else
        [files_section, *directory_sections]
      end
    result_sections.map(&:format_section).join("\n")
  end

  def build_warning_message
    non_existent_paths.map do |path|
      "ls: #{path}: No such file or directory"
    end.join("\n")
  end

  def group_paths(filenames, reverse_flag)
    classified_paths = classify_paths(filenames)
    sort_paths(classified_paths, reverse_flag)
  end

  def classify_paths(filenames)
    paths = { files: [], directories: [], non_existent_paths: [] }
    if filenames.empty?
      paths[:directories] << '.'
    else
      filenames.each do |path|
        if File.file?(path)
          paths[:files] << path
        elsif File.directory?(path)
          paths[:directories] << path
        else
          paths[:non_existent_paths] << path
        end
      end
    end
    paths
  end

  def sort_paths(paths, reverse_flag)
    sorted_paths = paths.transform_values(&:sort)
    if reverse_flag
      [sorted_paths[:files].reverse, sorted_paths[:directories].reverse, sorted_paths[:non_existent_paths]]
    else
      sorted_paths.values
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  warning_message, normal_result = Ls.new.build_results
  warn warning_message unless warning_message.empty?
  puts normal_result unless normal_result.empty?
end
