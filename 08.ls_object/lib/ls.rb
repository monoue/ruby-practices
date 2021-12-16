#!/usr/bin/env ruby

# frozen_string_literal: true

require_relative './ls_option'
require_relative './sections'

class Ls
  def initialize(command_line_arguments = ARGV)
    @ls_option = LsOption.new(command_line_arguments)
    @filenames, @directory_paths, @non_existent_paths = group_paths
  end

  def build_results
    [build_warning_message, build_result]
  end

  private

  attr_reader :ls_option, :filenames, :directory_paths, :non_existent_paths

  def build_result
    files_section =
      if ls_option.long_format?
        Sections::LongFormatFilesSection.new(filenames)
      else
        Sections::NormalFormatFilesSection.new(filenames)
      end
    directory_sections = directory_paths.map do |directory_path|
      Sections::DirectorySection.new(directory_path, ls_option)
    end
    "#{[files_section, *directory_sections].map(&:format_section).join("\n").strip}\n"
  end

  def build_warning_message
    non_existent_paths.map do |path|
      "ls: #{path}: No such file or directory"
    end.join("\n")
  end

  def group_paths
    classified_paths = classify_paths(ls_option.filenames)
    sort_paths(classified_paths)
  end

  def classify_paths(filenames)
    paths = { filenames: [], directory_paths: [], non_existent_paths: [] }
    if filenames.empty?
      paths[:directory_paths] << '.'
    else
      filenames.each do |path|
        if File.file?(path)
          paths[:filenames] << path
        elsif File.directory?(path)
          paths[:directory_paths] << path
        else
          paths[:non_existent_paths] << path
        end
      end
    end
    paths
  end

  def sort_paths(paths)
    sorted_paths = paths.transform_values(&:sort)
    if ls_option.reverse?
      [sorted_paths[:filenames].reverse, sorted_paths[:directory_paths].reverse, sorted_paths[:non_existent_paths]]
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
